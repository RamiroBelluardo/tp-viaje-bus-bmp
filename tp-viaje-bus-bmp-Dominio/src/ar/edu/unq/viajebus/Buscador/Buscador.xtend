package ar.edu.unq.viajebus.Buscador

import java.util.List
import org.joda.time.LocalDateTime
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Micro.Pasaje

class Buscador {
	public List<Viaje> viajes
	public List<Pasaje> pasajes

	def buscarViajePorCiudad(String ciudad) {
		viajes.filter[viajes|viajes.recorrido.contains(ciudad)]
	}

	def buscarViajePorFechaPartida(LocalDateTime fecha) {
		viajes.filter[viajes|viajes.fechaPartida.getDayOfWeek.equals(fecha.getDayOfWeek)]
			  .filter[viajes|viajes.fechaPartida.getMonthOfYear.equals(fecha.getMonthOfYear)]
			  .filter[viajes|viajes.fechaPartida.getYear.equals(fecha.getYear)]
			  
	}

	def buscarViajePorFechaLlegada(LocalDateTime fecha) {
		viajes.filter[viajes|viajes.fechaLlegada.getDayOfWeek.equals(fecha.getDayOfWeek)]
			  .filter[viajes|viajes.fechaLlegada.getMonthOfYear.equals(fecha.getMonthOfYear)]
			  .filter[viajes|viajes.fechaLlegada.getYear.equals(fecha.getYear)]
	}
	
	def buscarViajesQueNoPasaron() {
		val LocalDateTime now = LocalDateTime.now
		viajes.filter[viajes | viajes.fechaPartida.isAfter(now)]
	}
	
	def buscarPasajesQueNoPasaron() {
		val LocalDateTime now = LocalDateTime.now
		pasajes.filter[pasajes | pasajes.viaje.fechaPartida.isAfter(now)]
	
	}
	
}
	
