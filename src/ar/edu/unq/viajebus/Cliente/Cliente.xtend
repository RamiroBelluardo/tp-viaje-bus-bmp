package ar.edu.unq.viajebus.Cliente

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.Micro.Pasaje
import java.util.List

@Accessors
class Cliente {

	String nombre
	String apellido
	String dni
	String mail
	String telefono
	List<Pasaje> pasajes

	new(String nombre, String apellido, String dni, String mail, String telefono) {
		this.nombre = nombre
		this.apellido = apellido
		this.dni = dni
		this.mail = mail
		this.telefono = telefono
		this.pasajes = newArrayList
	}

	def agregarPasaje(Pasaje pasaje) {
		this.pasajes.add(pasaje)
	}

}
