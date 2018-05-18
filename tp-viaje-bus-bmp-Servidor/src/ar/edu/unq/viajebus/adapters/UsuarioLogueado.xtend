package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Cliente.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class UsuarioLogueado {
	String username
	String password
	ClienteResumido cliente

	new(Usuario usuario) {
		this.username = usuario.username
		this.password = usuario.password
		this.cliente = new ClienteResumido(usuario.cliente)

	}
}
