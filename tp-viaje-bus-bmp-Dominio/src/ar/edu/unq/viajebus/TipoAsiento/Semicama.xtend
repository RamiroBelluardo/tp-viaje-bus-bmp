package ar.edu.unq.viajebus.TipoAsiento

import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@TransactionalAndObservable
class Semicama extends TipoAsiento {
	new() {
		this.nombre = "Semicama"
		this.porcentaje = 0
	}
}
