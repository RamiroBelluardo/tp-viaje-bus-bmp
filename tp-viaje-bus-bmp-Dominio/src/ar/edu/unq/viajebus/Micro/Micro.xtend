package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class Micro extends Entity implements Cloneable {

	String patente
	TipoAsiento tipoDeAsiento
	Boolean tieneTele
	Integer cantidadAsientos

	new(String patente, TipoAsiento tipoAsiento, Boolean tieneTele, Integer cantidadAsientos) {
		this.patente = patente
		this.tipoDeAsiento = tipoAsiento
		this.tieneTele = tieneTele
		this.cantidadAsientos = cantidadAsientos
	}

	new() {
		this.tipoDeAsiento = tipoDeAsiento
	}
	


}
