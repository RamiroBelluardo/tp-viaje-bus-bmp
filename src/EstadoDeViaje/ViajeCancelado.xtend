package EstadoDeViaje

import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.Micro.Viaje

class ViajeCancelado extends EstadoDeViaje{
	
	override cancelar(Viaje viaje) {
		throw new UserException("El viaje ya se encuentra cancelado")
	}
	
	override eliminar(Viaje viaje) {
		throw new UserException("El viaje se encuentra cancelado")
	}
	
}