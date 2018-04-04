package ar.edu.unq.viajebus.EstadoDeViaje

import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.commons.model.exceptions.UserException

class Aprobado extends EstadoDeViaje {

	override cancelar(Viaje viaje) {
		viaje.pasajes.forEach(pasaje|pasaje.cancelar)
		viaje.estado = new ViajeCancelado
	}

	override eliminar(Viaje viaje) {
		if (viaje.hayPasajesVendidos) {
			throw new UserException("No se puede eliminar un viaje con pasajes vendidos")
		} else {
			viaje.estado = new Eliminado
		}
	}

}
