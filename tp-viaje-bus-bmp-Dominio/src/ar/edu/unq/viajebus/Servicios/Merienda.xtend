package ar.edu.unq.viajebus.Servicios

import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors

@TransactionalAndObservable
@Accessors
class Merienda extends Servicio {
	new() {
		this.precio = 30
		this.nombre = "Merienda"
	}
}
