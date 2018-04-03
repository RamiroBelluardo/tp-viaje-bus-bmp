package ar.edu.unq.viajebus.Micro

class Pasaje {
	
	Viaje viaje
	Integer nroAsiento
	
	new(Viaje viaje, Integer nroAsiento) {
		this.viaje = viaje
		this.nroAsiento = nroAsiento
	}
	
}
