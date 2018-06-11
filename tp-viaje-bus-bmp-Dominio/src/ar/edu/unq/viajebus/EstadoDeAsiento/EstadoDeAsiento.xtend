package ar.edu.unq.viajebus.EstadoDeAsiento

import ar.edu.unq.viajebus.Micro.Asiento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
abstract class EstadoDeAsiento {
	String nombre

	def void siguiente(Asiento asiento) {
		asiento.estado = this.proximo
	}

	def void anterior(Asiento asiento) {
		asiento.estado = this.previo
	}

	def EstadoDeAsiento proximo()

	def EstadoDeAsiento previo()
}
