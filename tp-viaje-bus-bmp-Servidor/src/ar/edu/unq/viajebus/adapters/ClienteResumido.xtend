package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Cliente.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ClienteResumido {
	String nombre
	String apellido
	String mail
	String dni
	String telefono

	new(Usuario usuario) {
		this.nombre = usuario.cliente.nombre
		this.apellido = usuario.cliente.apellido
		this.dni = usuario.cliente.dni
		this.mail = usuario.cliente.mail
		this.telefono = usuario.cliente.telefono
	}
}
