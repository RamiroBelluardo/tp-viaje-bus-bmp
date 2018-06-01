package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Cliente.Usuario
import org.uqbar.commons.model.exceptions.UserException

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

	def buscarParaCrear(String username) {
		val user = allInstances.findFirst[usuario|this.match(username, usuario.username)]
		if (user !== null) {
			throw new UserException("El username ya existe")
		}
		user
	}

	def buscarParaEditar(String username) {
		val usuario = allInstances.findFirst[usuario|this.match(username, usuario.username)]
		if (usuario === null) {
			throw new UserException("El username y/o el password es incorrecto")
		}
		usuario
	}

//	def search(String username,String password) {
//		allInstances.filter [ usuario |
//			this.match2(username, usuario.username) && this.match2(password, usuario.password) ].toList
//	}
	def buscarParaLogin(String username, String password) {
	
		if (username === null || username.equals("")) {
			throw new UserException("El username no puede ser vacío")
		}
		if (password === null || password.equals("")) {
			throw new UserException("El password no puede ser vacío")
		}
		
		this.buscarParaEditar(username)
		
		val usuario = allInstances.findFirst [ usuario |
			this.match2(username, usuario.username) && this.match2(password, usuario.password)
		]
		if (usuario === null) {
			throw new UserException("El username y/o el password es incorrecto")
		}

		usuario
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
