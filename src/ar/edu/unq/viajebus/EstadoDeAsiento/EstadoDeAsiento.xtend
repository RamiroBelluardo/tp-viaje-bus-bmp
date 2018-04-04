package ar.edu.unq.viajebus.EstadoDeAsiento

import ar.edu.unq.viajebus.Micro.Asiento

abstract class EstadoDeAsiento {

	def void siguiente(Asiento asiento) {
		asiento.estado = this.proximo
	}

	def void anterior(Asiento asiento) {
		asiento.estado = this.previo
	}

	def EstadoDeAsiento proximo()

	def EstadoDeAsiento previo()
}
