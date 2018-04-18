package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.TipoAsiento.Cama
import org.joda.time.LocalDateTime

class RepoPasajes {

	static RepoPasajes instance
//	RepoViajes repoViajes

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPasajes()
		}
		instance
	}
	
	// PASAJE:   new(Cliente cliente, Viaje viaje, Integer nroAsiento)
	// CLIENTE:  new(String nombre, String apellido, String dni, String mail, String telefono)
	// VIAJE:    new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro)
	
		def getPasajes() {
			
		val micro1 = new Micro("ABC123", new Cama, true)
		
		val partidaMicro1 = new LocalDateTime(2018,6,13,21,00) 
		val llegadaMicro1 = new LocalDateTime(2018,6,14,21,15) 
		
		val viaje = new Viaje(partidaMicro1, llegadaMicro1, micro1)	
					
			
		//val viaje1 = repoViajes.viajes.get(0)
		val cliente1 = new Cliente("Lucas", "Pier", "111111", "lg.piergiacomi@gmail.com", "44444444")
		val Integer nro = 1
		val pasaje1 = new Pasaje(cliente1, viaje, nro)
		
		#[pasaje1]
	}
}