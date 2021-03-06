package ar.edu.unq.viajebus.Cliente

import ar.edu.unq.viajebus.Micro.Pasaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@TransactionalAndObservable
class Cliente extends Entity implements Cloneable {

	static final int MIN_DIGITOS_DNI = 7
	static final int MIN_DIGITOS_MAIL = 5

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

	new() {
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


	@Dependencies("nombre", "apellido", "dni", "mail")
	def Boolean getValido() {
		 this.nombre !== null && this.nombre !== "" 
		 && this.apellido !== null && this.apellido !== ""
		 && this.dni !== null && this.dni !== ""
		 && this.mail !== null && this.mail !== ""
	}


	def String getNombreCompleto() {
		//'''«nombre» «apellido»'''
		nombre + " " + apellido
	}
	
	def validar() {
		if (nombre === null || nombre.trim.equals("")) {
			throw new UserException("Debe ingresar nombre")
		}
		if (apellido === null || apellido.trim.equals("")) {
			throw new UserException("Debe ingresar apellido")
		}
		if (dni === null || dni.trim.equals("")) {
			throw new UserException("Debe ingresar dni")
		}
		if (dni.length < MIN_DIGITOS_DNI) {
			throw new UserException("El dni debe tener al menos " +MIN_DIGITOS_DNI + " dígitos")
		}
		if (mail === null || mail.trim.equals("")) {
			throw new UserException("Debe ingresar mail")
		}
		if (mail === null || mail.length < MIN_DIGITOS_MAIL) {
			throw new UserException("El mail debe tener al menos " +MIN_DIGITOS_MAIL + " caracteres")
			
		}
		if (!mail.contains("@")) {
			throw new UserException("El mail debe contener un @ intermedio")
			
		}
	}
	
	def removerPasaje(Pasaje pasaje) {
		this.pasajes.remove(pasaje)
	}
	
}
