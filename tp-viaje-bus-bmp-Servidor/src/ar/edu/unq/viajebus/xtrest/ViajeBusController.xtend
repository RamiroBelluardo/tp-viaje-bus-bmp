package ar.edu.unq.viajebus.xtrest

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Cliente.Usuario
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.adapters.PasajeConUsuario
import ar.edu.unq.viajebus.adapters.UsuarioLogueado
import ar.edu.unq.viajebus.adapters.ViajeResumido
import ar.edu.unq.viajebus.runnable.ViajeBusBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoPasajes
import repo.RepoUsuarios
import repo.RepoViajes
import transformer.LocalDateTransformer

@Controller
class ViajeBusController {
	extension JSONUtils = new JSONUtils

	ViajeBusBootstrap bootstrap = new ViajeBusBootstrap
	RepoClientes repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoClientes
	RepoViajes repoViajes = ApplicationContext.instance.getSingleton(typeof(Viaje)) as RepoViajes
	RepoMicros repoMicros = ApplicationContext.instance.getSingleton(typeof(Micro)) as RepoMicros
	RepoPasajes repoPasajes = ApplicationContext.instance.getSingleton(typeof(Pasaje)) as RepoPasajes
	RepoUsuarios repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepoUsuarios

	new() {
		this.bootstrap.run
	}

	@Post('/usuarios')
	/*
	 * Crea un nuevo usuario en el servidor
	 */
	def Result crearUsuario(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(getErrorJson("Faltan datos del usuario a agregar"))
			}
			val nuevo = body.fromJson(Usuario)
			nuevo.validar
			repoUsuarios.buscarParaCrear(nuevo.username)
			repoClientes.create(nuevo.cliente)
			val nuevoUsuario = repoUsuarios.create(nuevo.username, nuevo.password, nuevo.cliente)
			ok('''{ "id" : "«nuevoUsuario.id»" }''')

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}

	@Put('/usuarios/:username')
	/*
	 * Actualiza datos del cliente asociado al usuario.
	 * Username y password no se pueden cambiar.
	 * Todos los datos son obligatorios menos el teléfono
	 */
	def Result actualizar(@Body String body) {
		try {
			val actualizado = body.fromJson(Usuario)
			val usuario = repoUsuarios.buscarParaEditar(username)

			if (usuario.username != actualizado.username) {
				return badRequest(getErrorJson("No se puede modificar el username"))
			}
			if (usuario.password != actualizado.password) {
				return badRequest(getErrorJson("No se puede modificar el password"))
			}
			actualizado.validar
			repoUsuarios.update(actualizado)
			ok('{ "status" : "OK" }');
		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}

	@Post('/login')
	/*
	 * Login de un usuario. Chequea que los datos sean correctos y que no haya datos vacíos
	 */
	def Result loginUsuario(@Body String body) {
		try {

			if (body === null || body.trim.equals("")) {
				return badRequest(getErrorJson("Faltan datos del usuario a agregar"))
			}

			val nuevo = body.fromJson(Usuario)
			val usuario = repoUsuarios.buscarParaLogin(nuevo.username, nuevo.password)

			ok(new UsuarioLogueado(usuario).toJson)

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Get('/viajes')
	/*
	 * Devuelve la lista de viajes según los criterios en la URL.
	 * Todos los criterios son opcionales.
	 */
	def Result buscar(String ciudadPartida, String ciudadLlegada, String fechaPartida, String fechaLlegada) {
		var formateador = new LocalDateTransformer
		var fechaPartidaFormateada = formateador.viewToModel(fechaPartida)
		var fechaLlegadaFormateada = formateador.viewToModel(fechaLlegada)
		var resultados = repoViajes.search(ciudadPartida, ciudadLlegada, fechaPartidaFormateada, fechaLlegadaFormateada)

		ok(resultados.map([each|new ViajeResumido(each)]).toJson)
	}

	@Post('/pasajes')
	/*
	 * Carga un pasaje nuevo al cliente asociado al usuario.
	 * Los datos de pago por el momento son ignorados.
	 */
	def Result comprarPasaje(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(getErrorJson("Faltan datos del pasaje a comprar"))
			}
			val pasajeConUsuario = body.fromJson(PasajeConUsuario)
			val user = repoUsuarios.buscarParaLogin(pasajeConUsuario.username, pasajeConUsuario.password)

			val viaje = repoViajes.searchById(pasajeConUsuario.viajeId)
			val nroAsiento = pasajeConUsuario.asiento

			if (!viaje.nrosAsientosDisponibles.contains(nroAsiento)) {
				return badRequest(getErrorJson("El asiento ya se encuentra reservado"))
			}

			val nuevoPasaje = repoPasajes.create(user.cliente, viaje, nroAsiento)
			nuevoPasaje.confirmar
			ok('''{ "id" : "«nuevoPasaje.id»" }''')

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Post('/pasajes/:idPasaje/cancelar')
	/*
	 * Cancela un pasaje previamente comprado.
	 * Verifica que el pasaje haya sido comprado por el cliente asociado al usuario
	 */
	def Result cancelarPasaje(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(getErrorJson("Faltan datos del pasaje a cancelar"))
			}
			val usuario = body.fromJson(Usuario)

			val usuarioExtraido = repoUsuarios.buscarParaLogin(usuario.username, usuario.password)
			val pasaje = repoPasajes.search(Integer.valueOf(idPasaje))

			if (pasaje.cliente.id !== usuarioExtraido.cliente.id) {
				return badRequest(getErrorJson("Este pasaje no le corresponde"))
			}

			pasaje.cancelar
			ok()

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

// ********************************************************
// ** OPCIONALES
// ********************************************************
	@Get('/micros')
	def Result buscarMicros() {
		ok(repoMicros.micros.toJson)
	}

	@Get('/clientes')
	def Result buscarClientes(String nombre, String apellido) {
		ok(repoClientes.search(nombre, apellido).toJson)
	}

	private def String getErrorJson(String message) {
		'''{ "error" : "«message»" }'''
	}

	def static void main(String[] args) {
		XTRest.start(9200, ViajeBusController)
	}
}
