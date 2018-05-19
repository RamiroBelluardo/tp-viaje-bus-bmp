package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Micro.Pasaje
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PasajeConViaje {
	
	Integer asiento
	ViajeResumido viaje

	
	new(Pasaje pasaje){
		this.viaje = new ViajeResumido(pasaje.viaje)
		this.asiento = pasaje.nroAsiento
	}
	
}