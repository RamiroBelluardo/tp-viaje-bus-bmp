package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.Cliente.Cliente
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Pasaje {
	
	Cliente cliente
	Viaje viaje
	Asiento asiento
	
	new(Cliente cliente, Viaje viaje, Integer nroAsiento) {
		this.cliente = cliente
		cliente.pasajes.add(this)
		this.viaje = viaje
		this.asiento = viaje.micro.asiento(nroAsiento)
		this.viaje.micro.reservar(nroAsiento)
	}

	
}
