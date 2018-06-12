package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.xtrest.DatosPago
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PasajeConUsuario {
	
	String username
	String password
	Integer viajeId
	Integer asiento
	DatosPago pago
	
	new(){
		this.username = username
		this.password = password
		this.viajeId = viajeId
		this.asiento = asiento
		this.pago = new DatosPago()
	}
	
}