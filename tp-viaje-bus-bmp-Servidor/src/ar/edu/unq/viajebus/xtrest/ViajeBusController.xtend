package ar.edu.unq.viajebus.xtrest

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Cliente.Usuario
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.adapters.ClienteResumido
import ar.edu.unq.viajebus.adapters.PasajeConUsuario
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
	def Result crearUsuario(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(' "error" : "Faltan datos del usuario a agregar" ')
			}

			val nuevo = body.fromJson(Usuario)
			nuevo.validar
			val checkUser = repoUsuarios.search(nuevo.username)
			if (checkUser !== null) {

				return badRequest('{"error" : "El username ya existe"}')
			}

			repoClientes.create(nuevo.cliente)
			val nuevoUsuario = repoUsuarios.create(nuevo.username, nuevo.password, nuevo.cliente)

			ok('''{ "id" : "«nuevoUsuario.id»" }''')

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Put('/usuarios/:username')
	def Result actualizar(@Body String body) {
		try {
			val actualizado = body.fromJson(Usuario)
			val usuario = repoUsuarios.search(username)
			if (usuario === null) {
				return badRequest(' "error" : "El usuario no existe" ')
			}
			if (usuario.username != actualizado.username) {
				return badRequest(' "error" : "No se puede modificar el username" ')
			}
			if (usuario.password != actualizado.password) {
				return badRequest(' "error" : "No se puede modificar el password" ')
			}
			actualizado.validar
			repoUsuarios.update(actualizado)
			ok('{ "status" : "OK" }');
		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}

	@Post('/login')
	def Result loginUsuario(@Body String body) {
		try {
			
			
			if (body === null || body.trim.equals("")) {
				return badRequest(' "error" : "Faltan datos del usuario a agregar" ')
			}

			val nuevo = body.fromJson(Usuario)
			repoUsuarios.buscarUsuario(nuevo.username, nuevo.password)

			if (nuevo.username === null || nuevo.username.equals("")) {
				return badRequest(' "error" : "El username no puede ser vacio" ')
			}
			if (nuevo.password === null || nuevo.password.equals("")) {
				return badRequest(' "error" : "El password no puede ser vacio" ')
			}

			val usuario = repoUsuarios.search(nuevo.username, nuevo.password)
			if (usuario.isEmpty) {
				return badRequest(' "error" : "El username y/o el password es incorrecto" ')
			}
			ok(new ClienteResumido(usuario.get(0)).toJson)

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Get('/viajes')
	def Result buscar(String ciudadPartida, String ciudadLlegada, String fechaPartida, String fechaLlegada) {
		var formateador = new LocalDateTransformer
		var fechaPartidaFormateada = formateador.viewToModel(fechaPartida)
		var fechaLlegadaFormateada = formateador.viewToModel(fechaLlegada)

		var resultados = repoViajes.search(ciudadPartida, ciudadLlegada, fechaPartidaFormateada, fechaLlegadaFormateada)

		ok(resultados.map([each|new ViajeResumido(each)]).toJson)
	}

	@Post('/pasajes')
	def Result comprarPasaje(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(' "error" : "Faltan datos del pasaje a comprar" ')
			}
			val pasajeConCliente = body.fromJson(PasajeConUsuario)

			if (repoUsuarios.search(pasajeConCliente.username, pasajeConCliente.password).isEmpty) {
				return badRequest(' "error" : "El usuario no existe" ')
			}

			val usuario = repoUsuarios.buscarUsuario(pasajeConCliente.username, pasajeConCliente.password)
			val viaje = repoViajes.searchById(pasajeConCliente.viajeId)
			val nroAsiento = pasajeConCliente.asiento

			if (!viaje.nrosAsientosDisponibles.contains(nroAsiento)) {
				return badRequest(' "error" : "El asiento ya se encuentra reservado" ')
			}

			val nuevoPasaje = repoPasajes.create(usuario.cliente, viaje, nroAsiento)
			nuevoPasaje.confirmar
			ok('''{ "id" : "«nuevoPasaje.id»" }''')

		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}

	}

	@Post('/pasajes/:idPasaje/cancelar')
	def Result cancelarPasaje(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest(' "error" : "Faltan datos del pasaje a cancelar" ')
			}
			val usuario = body.fromJson(Usuario)
			val usuarioExtraido = repoUsuarios.buscarUsuario(usuario.username, usuario.password)

//			if (repoUsuarios.search(usuario.username, usuario.password).isEmpty) {
//				return badRequest(' "error" : "El usuario no existe" ')
//			}

			val pasaje = repoPasajes.search(Integer.valueOf(idPasaje))

			if (pasaje.isEmpty) {
				return badRequest(' "error" : "El pasaje no existe" ')
			}

			if (pasaje.get(0).cliente.id !== usuarioExtraido.cliente.id) {
				return badRequest(' "error" : "Este pasaje no le corresponde" ')
			}

			pasaje.get(0).cancelar
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

	@Get('/usuarios')
	def Result buscarUsuarios(String nombre, String apellido) {
		ok(repoUsuarios.search(nombre, apellido).toJson)
	}

	private def String getErrorJson(String message) {
		'''{ "error" : "«message»" }'''
	}

	def static void main(String[] args) {
		XTRest.start(9200, ViajeBusController)
	}
}
