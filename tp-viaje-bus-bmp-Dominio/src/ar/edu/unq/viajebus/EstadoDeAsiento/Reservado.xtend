package ar.edu.unq.viajebus.EstadoDeAsiento

import org.uqbar.commons.model.exceptions.UserException

class Reservado extends EstadoDeAsiento {

	override proximo() {
		throw new UserException("El asiento ya se encuentra reservado")
	}

	override previo() {
		new Disponible
	}

}
