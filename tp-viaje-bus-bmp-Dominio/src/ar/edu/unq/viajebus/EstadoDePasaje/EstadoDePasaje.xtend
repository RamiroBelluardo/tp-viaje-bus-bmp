package ar.edu.unq.viajebus.EstadoDePasaje

import ar.edu.unq.viajebus.Micro.Pasaje
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
abstract class EstadoDePasaje {
	String nombre

	def void siguiente(Pasaje pasaje) {
		pasaje.estado = this.proximo
	}

	def void anterior(Pasaje pasaje) {
		pasaje.estado = this.previo
	}

	def EstadoDePasaje proximo()

	def EstadoDePasaje previo()

}
