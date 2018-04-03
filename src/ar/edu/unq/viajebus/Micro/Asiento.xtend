package ar.edu.unq.viajebus.Micro

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.EstadoDeAsiento.EstadoDeAsiento
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible

@Accessors
class Asiento {
	int numero
	//boolean disponibilidad
	EstadoDeAsiento estado

	new() {
		//this.disponibilidad = true
		this.estado = new Disponible
	}
	
	def reservar() {
		this.estado.siguiente(this)
	}
	
	def liberar() {
		this.estado.anterior(this)
	}


}
