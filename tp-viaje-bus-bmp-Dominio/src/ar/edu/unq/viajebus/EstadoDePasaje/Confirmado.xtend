package ar.edu.unq.viajebus.EstadoDePasaje

import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Mailing.GMailSender

class Confirmado extends EstadoDePasaje {

	override anterior(Pasaje pasaje) {
		super.anterior(pasaje)
		//GMailSender.instance.notificarCancelacionDePasaje(pasaje)
	}

	override proximo() {
		throw new UserException("El pasaje ya se encuentra confirmado")
	}

	override previo() {
		new Cancelado
	}


}
