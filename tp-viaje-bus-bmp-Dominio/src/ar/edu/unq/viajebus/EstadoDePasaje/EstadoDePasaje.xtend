package ar.edu.unq.viajebus.EstadoDePasaje

import ar.edu.unq.viajebus.Micro.Pasaje

abstract class EstadoDePasaje {

	def void siguiente(Pasaje pasaje) {
		pasaje.estado = this.proximo
	}

	def void anterior(Pasaje pasaje) {
		pasaje.estado = this.previo
	}

	def EstadoDePasaje proximo()

	def EstadoDePasaje previo()
}
