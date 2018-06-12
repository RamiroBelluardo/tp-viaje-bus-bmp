package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.EstadoDePasaje.EstadoDePasaje
import ar.edu.unq.viajebus.Micro.Pasaje
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PasajeConViaje {
	
	int id
	Integer asiento
	ViajeResumido viaje
	EstadoDePasaje estado

	
	new(Pasaje pasaje){
		this.id = pasaje.id
		this.viaje = new ViajeResumido(pasaje.viaje)
		this.asiento = pasaje.nroAsiento
		this.estado = pasaje.estado
	}
	
}