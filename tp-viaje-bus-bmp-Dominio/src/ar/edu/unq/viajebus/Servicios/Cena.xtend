package ar.edu.unq.viajebus.Servicios

import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors

@TransactionalAndObservable
@Accessors
class Cena extends Servicio {
	new() {
		this.precio = 50
		this.nombre = "Cena"
	}

}
