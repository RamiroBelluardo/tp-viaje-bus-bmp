package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
class RepoClientes extends CollectionBasedRepo<Cliente> {

	// ********************************************************
	// ** Altas y bajas
	// ********************************************************
	def Cliente create(String cNombre, String cApellido, String cDni, String cMail, String cTelefono) {
		val cliente = new Cliente => [
			nombre = cNombre
			apellido = cApellido
			dni = cDni
			mail = cMail
			telefono = cTelefono
		]
		this.create(cliente)
		cliente
	}

	def search(String nombre, String apellido) {
		allInstances.filter[clientes|this.match(nombre, clientes.nombre) && this.match(apellido, clientes.apellido)].
			toList
	}

	def searchByMail(String mail) {
		allInstances.findFirst[clientes|this.match(mail, clientes.mail)]
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue === null) {
			return true
		}
		if (realValue === null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}

	override protected getCriterio(Cliente example) {
		null
	}

	override createExample() {
		new Cliente
	}

	override getEntityType() {
		typeof(Cliente)
	}

	def getClientes() {
		allInstances
	}
}
