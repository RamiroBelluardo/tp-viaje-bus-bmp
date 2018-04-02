package ar.edu.unq.viajebus.Micro

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Asiento {
	int numero
	boolean disponibilidad

	new() {
		this.disponibilidad = true
	}

	def estaDisponible() {
		disponibilidad == true
	}

}
