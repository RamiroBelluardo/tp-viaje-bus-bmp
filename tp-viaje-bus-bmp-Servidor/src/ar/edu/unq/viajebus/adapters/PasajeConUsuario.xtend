package ar.edu.unq.viajebus.adapters

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.xtrest.DatosPago

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