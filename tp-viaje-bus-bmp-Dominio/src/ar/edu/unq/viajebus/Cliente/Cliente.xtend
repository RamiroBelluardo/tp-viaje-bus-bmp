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

	static final int MIN_DIGITOS_DNI = 8
	static final int MAX_DIGITOS_DNI = 9
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
	}

	def agregarPasaje(Pasaje pasaje) {
		this.pasajes.add(pasaje)
	}

	def void setDni(String unDNI) {
		if (unDNI.length < MIN_DIGITOS_DNI) {
			throw new UserException('''El DNI debe tener por lo menos «MIN_DIGITOS_DNI» dígitos''')
		}
		if (unDNI.length > MAX_DIGITOS_DNI) {
			throw new UserException('''El DNI no debe tener más de «MAX_DIGITOS_DNI» dígitos''')
		}
		this.dni = unDNI
	}

//	//@Dependencies("nombre", "apellido", "dni", "mail")
//	def void getValido() {
//		if (this.nombre == null || this.apellido == null || this.dni == null || this.mail == null){
//			throw new UserException('''Debe rellenar los campos obligatorios''')
//		}
//	}
	@Dependencies("nombre", "apellido", "dni", "mail")
	def Boolean getValido() {
		 this.nombre !== null && this.nombre !== "" 
		 && this.apellido !== null && this.apellido !== ""
		 && this.dni !== null && this.dni !== ""
		 && this.mail !== null && this.mail !== ""
	}

	def void setMail(String unMail) {
		var lastChar = ""
		if (unMail.length > 0) {
			lastChar = unMail.substring(unMail.length() - 1);
		}
		if (unMail === null || unMail.length < MIN_DIGITOS_MAIL) {
			throw new UserException('''El mail debe tener al menos «MIN_DIGITOS_MAIL» caracteres''')
		}
		if (!unMail.contains("@") || (lastChar == "@")) {
			throw new UserException('''El Mail debe contener un @ intermedio''')
		}
		this.mail = unMail
	}

	def getNombreCompleto() {
		'''«nombre» «apellido»'''
	}
}
