package ar.edu.unq.viajebus.EstadoDePasaje

import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Mailing.GMailSender

class ListoParaComprar extends EstadoDePasaje {

	override siguiente(Pasaje pasaje) {
		super.siguiente(pasaje)
		GMailSender.instance.notificarCompraDePasaje(pasaje)
	}

	override proximo() {
		new Confirmado
	}

	override previo() {
		new Cancelado
	}

}
