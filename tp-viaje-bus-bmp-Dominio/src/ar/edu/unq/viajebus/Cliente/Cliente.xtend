package ar.edu.unq.viajebus.Cliente

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.Micro.Pasaje
import java.util.List
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.Entity

@Accessors
@Observable
class Cliente extends Entity implements Cloneable {

	static final int MAX_DIGITOS = 7

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
	}

	def agregarPasaje(Pasaje pasaje) {
		this.pasajes.add(pasaje)
	}

	def void setDni(String unDNI) {
		if (unDNI === "" || unDNI.length <= MAX_DIGITOS) {
			throw new UserException("El DNI debe tener minimamente 8 d�gitos")
		}
		if (unDNI.charAt(2).toString !== (".")){// || unDNI.charAt(6).equals(".")) {
			throw new UserException("El DNI debe tener el formato nn.nnn.nnn")
		}
		this.dni = unDNI
	}

	def void setMail(String unMail) {
		if (!unMail.contains("@")) {
			throw new UserException("El Mail debe contener @")
		}
		if (!unMail.contains(".com")) {
			throw new UserException("Mail inválido")
		}
		this.mail = unMail
	}

}
