package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.EstadoDeAsiento.EstadoDeAsiento
import ar.edu.unq.viajebus.Micro.Asiento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AsientoResumido {

	Integer numero
	EstadoDeAsiento estado

	new(Asiento asiento) {
		this.numero = asiento.numero
		this.estado = asiento.estado
	}
}
