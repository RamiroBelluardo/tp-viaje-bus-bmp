package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable

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
