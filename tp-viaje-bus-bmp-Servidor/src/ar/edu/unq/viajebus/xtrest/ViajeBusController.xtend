package ar.edu.unq.viajebus.xtrest

import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import repo.RepoClientes
import ar.edu.unq.viajebus.runnable.ViajeBusBootstrap

@Controller
class ViajeBusController {
	extension JSONUtils = new JSONUtils

	ViajeBusBootstrap bootstrap = new ViajeBusBootstrap
	RepoClientes repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoClientes

	new() {
		this.bootstrap.run
	}


	@Post('/usuarios')
	def Result crearUsuario(@Body String body) {
		try {
			if (body === null || body.trim.equals("")) {
				return badRequest("Faltan datos del usuario a agregar")
			}
			val nuevo = body.fromJson(Cliente)
			nuevo.validar
			val nuevoCliente = repoClientes.create(nuevo.nombre, nuevo.apellido, nuevo.dni, nuevo.mail, nuevo.telefono)

			ok('''{ "id" : "«nuevoCliente.id»" }''')
		} catch (UserException e) {
			badRequest(getErrorJson(e.message))
		}
	}

	private def String getErrorJson(String message) {
		'''{ "error" : "«message»" }'''
	}

	def static void main(String[] args) {
		XTRest.start(9200, ViajeBusController)
	}
}
