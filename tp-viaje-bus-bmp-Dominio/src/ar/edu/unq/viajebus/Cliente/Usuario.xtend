package ar.edu.unq.viajebus.Cliente

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@TransactionalAndObservable
class Usuario extends Entity implements Cloneable {
	String username
	String password
	Cliente cliente

	new(String username, String password, Cliente cliente) {
		this.username = username
		this.password = password
		this.cliente = cliente
	}

	new() {
	}

	def validar() {
		if (username === null || username.trim.equals("")) {
			throw new UserException("Debe ingresar un username")
		}
		if (username.length() < 5) {
			throw new UserException("El username debe tener 5 caracteres al menos")
		}

		if (password === null || password.trim.equals("")) {
			throw new UserException("Debe ingresar un password")
		}

		if (password.length() < 4) {
			throw new UserException("El password debe tener 4 caracteres al menos")
		}
		cliente.validar()
//		if (cliente.nombre === null || cliente.nombre.trim.equals("")) {
//			throw new UserException("Debe ingresar nombre")
//		}
//		if (cliente.apellido === null || cliente.apellido.trim.equals("")) {
//			throw new UserException("Debe ingresar apellido")
//		}
//		if (cliente.dni === null || cliente.dni.trim.equals("")) {
//			throw new UserException("Debe ingresar dni")
//		}
//		if (cliente.mail === null || cliente.mail.trim.equals("")) {
//			throw new UserException("Debe ingresar mail")
//		}
	}

}
