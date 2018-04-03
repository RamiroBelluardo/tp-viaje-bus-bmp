package ar.edu.unq.viajebus.Cliente

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Micro.Pasaje

@Accessors
class Cliente {
	
	String nombre
	String apellido
	String dni
	String mail
	String telefono
	
	new(String nombre, String apellido, String dni, String mail, String telefono) {
		this.nombre = nombre
		this.apellido = apellido
		this.dni = dni
		this.mail = mail
		this.telefono = telefono
	}
	

	
}
