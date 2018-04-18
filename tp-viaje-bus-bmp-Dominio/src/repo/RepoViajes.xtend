package repo

import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.TipoAsiento.Cama
import org.joda.time.LocalDateTime
import ar.edu.unq.viajebus.TipoAsiento.Semicama
import ar.edu.unq.viajebus.TipoAsiento.Ejecutivo
import ar.edu.unq.viajebus.Micro.Asiento

class RepoViajes {

	static RepoViajes instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoViajes()
		}
		instance
	}
	
	// VIAJE:    new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro)
	// MICRO:    new(String patente, TipoAsiento tipoAsiento, Boolean tieneTele)
	
		def getViajes() {
		val micro1 = new Micro("ABC123", new Cama, true)
		val micro2 = new Micro("AB123AB", new Semicama, false)
		val micro3 = new Micro("DCR283", new Ejecutivo, true)
		
		val asiento1 = new Asiento()
		val asiento2 = new Asiento()
		micro1.agregarAsiento(asiento1)
		micro1.agregarAsiento(asiento2)
		micro1.reservarAsiento(1)
		
		val partidaMicro1 = new LocalDateTime(2018,3,31,12,00) 
		val llegadaMicro1 = new LocalDateTime(2018,3,31,14,00) 
		val partidaMicro2 = new LocalDateTime(2018,1,1, 00, 00) 
		val llegadaMicro2 = new LocalDateTime(2018,1,2,00,00) 
		val partidaMicro3 = new LocalDateTime(2018,2,23,06,25) 
		val llegadaMicro3 = new LocalDateTime(2018,2,23,15,45) 
		
		val viaje = new Viaje(partidaMicro1, llegadaMicro1, micro1)
		val viaje2 = new Viaje(partidaMicro2, llegadaMicro2, micro2)
		val viaje3 = new Viaje(partidaMicro3, llegadaMicro3, micro3)
		#[viaje, viaje2, viaje3]
	}
}
