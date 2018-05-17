package ar.edu.unq.viajebus.TipoAsiento


import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@TransactionalAndObservable
class Ejecutivo extends TipoAsiento {
	new() {
		this.nombre = "Ejecutivo"
		this.porcentaje = 20
	}
}
