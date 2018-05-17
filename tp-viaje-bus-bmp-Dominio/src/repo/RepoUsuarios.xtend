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
		allInstances.filter [ usuario |
			this.match(username, usuario.username) ].toList
	}
	def search(String username,String password) {
		allInstances.filter [ usuario |
			this.match2(username, usuario.username) && this.match2(password, usuario.password) ].toList
	}
	
	def buscarUsuario(String username,String password) {
		allInstances.filter [ usuario |
			this.match2(username, usuario.username) && this.match2(password, usuario.password) ].get(0)
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
	def match2(Object expectedValue, Object realValue) {
		if (expectedValue === null) {
			return true
		}
		if (realValue === null) {
			return false
		}
		realValue.toString().equals(expectedValue.toString())
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
	

