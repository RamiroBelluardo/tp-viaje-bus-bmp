package ar.edu.unq.viajebus.EstadoDePasaje

import org.uqbar.commons.model.exceptions.UserException

class Cancelado extends EstadoDePasaje {
	
	new() {
		this.nombre = "Cancelado"
	}

	override proximo() {
		throw new UserException("El pasaje ya se encuentra cancelado")
	}

	override previo() {
		throw new UserException("El pasaje ya se encuentra cancelado")
	}
	


}
