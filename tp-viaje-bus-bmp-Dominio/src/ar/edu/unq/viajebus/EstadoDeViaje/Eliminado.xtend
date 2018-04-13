package ar.edu.unq.viajebus.EstadoDeViaje

import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.Micro.Viaje

class Eliminado extends EstadoDeViaje {

	override cancelar(Viaje viaje) {
		throw new UserException("El viaje se encuentra eliminado")
	}

	override eliminar(Viaje viaje) {
		throw new UserException("El viaje ya se encuentra eliminado")
	}

}
