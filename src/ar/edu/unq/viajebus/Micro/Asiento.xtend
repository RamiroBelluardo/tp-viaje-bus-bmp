package ar.edu.unq.viajebus.Micro

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.EstadoDeAsiento.EstadoDeAsiento
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible

@Accessors
class Asiento {
	Integer numero
	EstadoDeAsiento estado

	new() {
		this.estado = new Disponible
	}
	
	def reservar() {
		this.estado.siguiente(this)
	}
	
	def liberar() {
		this.estado.anterior(this)
	}


}
