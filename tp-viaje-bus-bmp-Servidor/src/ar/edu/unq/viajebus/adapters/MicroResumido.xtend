package ar.edu.unq.viajebus.adapters

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import ar.edu.unq.viajebus.Micro.Micro

@Accessors
class MicroResumido {

	String patente
	TipoAsiento tipoAsiento
	Boolean tieneTele
	Integer cantidadAsientos

	new(Micro micro) {
		this.patente = micro.patente
		this.tipoAsiento = micro.tipoDeAsiento
		this.tieneTele = micro.tieneTele
		this.cantidadAsientos = micro.cantidadAsientos
	}
}
