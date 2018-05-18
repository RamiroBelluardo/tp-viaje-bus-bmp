package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Cliente.Cliente
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ClienteResumido {

	String nombre
	String apellido
	String mail
	String dni
	String telefono

	new(Cliente cliente) {
		this.nombre = cliente.nombre
		this.apellido = cliente.apellido
		this.mail = cliente.mail
		this.dni = cliente.dni
		this.telefono = cliente.telefono

	}
}
