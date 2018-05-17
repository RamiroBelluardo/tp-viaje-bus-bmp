package ar.edu.unq.viajebus.TipoAsiento

import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@TransactionalAndObservable
class Cama extends TipoAsiento {
	new() {
		this.nombre = "Cama"
		this.porcentaje = 10
	}
}
