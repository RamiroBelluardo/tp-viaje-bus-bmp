package ar.edu.unq.viajebus.xtrest

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.runnable.ViajeBusBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoViajes
import repo.RepoUsuarios
import ar.edu.unq.viajebus.Cliente.Usuario
import org.uqbar.xtrest.api.annotation.Put
import ar.edu.unq.viajebus.adapters.ClienteResumido
import ar.edu.unq.viajebus.adapters.ViajeResumido
import org.joda.time.LocalDate
import transformer.LocalDateTransformer

@Controller
class ViajeBusController {
	extension JSONUtils = new JSONUtils

	ViajeBusBootstrap bootstrap = new ViajeBusBootstrap
	RepoClientes repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoClientes
	RepoViajes repoViajes = ApplicationContext.instance.getSingleton(typeof(Viaje)) as RepoViajes
	RepoMicros repoMicros = ApplicationContext.instance.getSingleton(typeof(Micro)) as RepoMicros
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
			if (!checkUser.isEmpty) {

				return badRequest(' "error" : "El username ya existe" ')
			}

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
			if (usuario.isEmpty) {
				return badRequest(' "error" : "El usuario no existe" ')
			}
			if (usuario.get(0).username != actualizado.username) {
				return badRequest(' "error" : "No se puede modificar el username" ')
			}
			if (usuario.get(0).password != actualizado.password) {
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
		if (resultados.isEmpty) {
			return badRequest(' "error" : "No existen viajes con tu parametro de busqueda" ')
		}
		
		ok(resultados.map([each|new ViajeResumido(each)]).toJson)
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
