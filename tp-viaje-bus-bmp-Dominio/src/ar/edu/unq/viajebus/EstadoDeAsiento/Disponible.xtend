package ar.edu.unq.viajebus.EstadoDeAsiento

import org.uqbar.commons.model.exceptions.UserException

class Disponible extends EstadoDeAsiento {

	new() {
		this.nombre = "Disponible"
	}

	override proximo() {
		new Reservado
	}

	override previo() {
		throw new UserException("El asiento ya se encuentra disponible")
	}

}
