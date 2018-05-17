package ar.edu.unq.viajebus.adapters

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PasajeConUsuario {
	
	String username
	String password
	Integer viajeId
	Integer asiento
	String numeroTarjeta
	Integer nroExpiracionTarjeta
	Integer mesExpiracionTarjeta
	
	new(){
		this.username = username
		this.password = password
		this.viajeId = viajeId
		this.asiento = asiento
		this.numeroTarjeta = numeroTarjeta
		this.nroExpiracionTarjeta = nroExpiracionTarjeta
		this.mesExpiracionTarjeta = mesExpiracionTarjeta
	}
	
}