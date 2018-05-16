package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Cliente.Usuario

@Observable
class RepoUsuarios extends CollectionBasedRepo<Usuario> {

	// ********************************************************
	// ** Altas y bajas
	// ********************************************************
	def Usuario create(String uUsername, String uPassword, Cliente uCliente) {
		val usuario = new Usuario => [
			username = uUsername
			password = uPassword
			cliente = uCliente
		]
		this.create(usuario)
		usuario
	}

	def search(String username) {
		allInstances.filter [ usuarios |
			this.match(username, usuarios.username) ].toList
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
	override protected getCriterio(Usuario example) {
		null
	}

	override createExample() {
		new Usuario
	}

	override getEntityType() {
		typeof(Usuario)
	}

	def getUsuarios() {
		allInstances
	}
}
	

