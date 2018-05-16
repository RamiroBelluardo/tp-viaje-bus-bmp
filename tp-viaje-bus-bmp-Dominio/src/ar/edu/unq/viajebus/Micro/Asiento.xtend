package ar.edu.unq.viajebus.Micro

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.EstadoDeAsiento.EstadoDeAsiento
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.Entity

@TransactionalAndObservable
@Accessors
class Asiento extends Entity implements Cloneable {
	Integer numero
	EstadoDeAsiento estado
	Micro micro

	new() {
		//this.numero = numero
		this.estado = new Disponible
	}

	def reservar() {
		this.estado.siguiente(this)
	}

	def liberar() {
		this.estado.anterior(this)
	}

}
