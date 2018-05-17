package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Pasaje
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PasajeResumido {

	Cliente cliente
	Integer nroAsiento

	new(Pasaje pasaje) {
		this.cliente = pasaje.cliente
		this.nroAsiento = pasaje.nroAsiento
	}
}
