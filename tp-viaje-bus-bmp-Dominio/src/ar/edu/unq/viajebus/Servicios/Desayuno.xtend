package ar.edu.unq.viajebus.Servicios

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
class Desayuno extends Servicio {
	new() {
		this.precio = 30
		this.nombre = "Desayuno"

	}

}
