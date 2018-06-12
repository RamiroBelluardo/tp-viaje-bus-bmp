package ar.edu.unq.viajebus.xtrest

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Cliente.Usuario
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.adapters.ClienteResumido
import ar.edu.unq.viajebus.adapters.PasajeConUsuario
import ar.edu.unq.viajebus.adapters.PasajeConViaje
import ar.edu.unq.viajebus.adapters.UsuarioLogueado
import ar.edu.unq.viajebus.adapters.UsuarioResumido
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
	val pagosMercado = new PagosMercadoClient()

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
			repoUsuarios.delete(usuario)
			repoUsuarios.create(actualizado)
			// repoUsuarios.update(actualizado)
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
	def Result comprarPasaje(String token, @Body String body) {

		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(getErrorJson("Faltan datos del pasaje a comprar"))
			}
			val pasajeConUsuario = body.fromJson(PasajeConUsuario)
			val user = repoUsuarios.buscarParaLogin(pasajeConUsuario.username, pasajeConUsuario.password)

			val viaje = repoViajes.searchById(pasajeConUsuario.viajeId)
			val nroAsiento = pasajeConUsuario.asiento

			if (nroAsiento === null) {
				return badRequest(getErrorJson("Por favor seleccione un asiento a comprar"))
			}

			if (!viaje.nrosAsientosDisponibles.contains(nroAsiento)) {
				return badRequest(getErrorJson("El asiento ya se encuentra reservado"))
			}

			pagosMercado.validarPago(pasajeConUsuario.pago, token)
			ok(getOkJson("Pago Aprobado"))

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
			ok('''{ "id de Pasaje cancelado" : "«pasaje.id»" }''')

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Get('/pasajes/:username')
	/*
	 * Devuelve la lista de pasajes comprados por el username pasado por parámetro.
	 */
	def Result pasajes() {
		try {
			var usuario = repoUsuarios.buscarParaEditar(username)
			var cliente = repoClientes.searchByMail(usuario.cliente.mail)
			var resultados = repoPasajes.search(cliente)

			ok(resultados.map([each|new PasajeConViaje(each)]).toJson)

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
		var resultados = repoClientes.search(nombre, apellido)
		ok(resultados.map([each|new ClienteResumido(each)]).toJson)
	}

	@Get('/usuarios')
	def Result buscarUsuarios() {
		var resultados = repoUsuarios.search
		ok(resultados.map([each|new UsuarioResumido(each)]).toJson)
	}

	@Get('/viaje/:idViaje')
	/*
	 * Devuelve el viaje asociado al ID de la URL.
	 */
	def Result buscarPorId() {
		try {
			var viaje = repoViajes.searchById(Integer.valueOf(idViaje))
			ok(new ViajeResumido(viaje).toJson)
		} catch (NumberFormatException ex) {
			badRequest(getErrorJson("El id debe ser un numero entero"))
		} catch (UserException e) {
			notFound(getErrorJson(e.message));
		}
	}

	@Get('/viajesActuales')
	/*
	 * Devuelve la lista de viajes sin mostrar viajes pasados.
	 */
	def Result buscarActuales() {
		var resultados = repoViajes.searchActuales()
		ok(resultados.map([each|new ViajeResumido(each)]).toJson)
	}


	@Get('/pasajesHistoricos/:username')
	/*
	 * Devuelve la lista de pasajes comprados por el username pasado por parámetro donde su fechaDeLlegada sea anterior a hoy.
	 */
	def Result pasajesHistoricos() {
		try {
			var usuario = repoUsuarios.buscarParaEditar(username)
			var cliente = repoClientes.searchByMail(usuario.cliente.mail)
			var resultados = repoPasajes.searchHistoricos(cliente)

			ok(resultados.map([each|new PasajeConViaje(each)]).toJson)

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}
	
	@Get('/pasajesCancelados/:username')
	/*
	 * Devuelve la lista de pasajes comprados por el username pasado por parámetro y que se hayan cancelado.
	 */
	def Result pasajesCancelados() {
		try {
			var usuario = repoUsuarios.buscarParaEditar(username)
			var cliente = repoClientes.searchByMail(usuario.cliente.mail)
			var resultados = repoPasajes.searchCancelados(cliente)

			ok(resultados.map([each|new PasajeConViaje(each)]).toJson)

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}
	
	private def String getOkJson(String message) {
		'''{ "ok" : "«message»" }'''
	}

	private def String getErrorJson(String message) {
		'''{ "error" : "«message»" }'''
	}

	def static void main(String[] args) {
		XTRest.start(9200, ViajeBusController)
	}
}
