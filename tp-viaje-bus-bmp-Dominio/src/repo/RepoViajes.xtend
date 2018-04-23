package repo

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import org.joda.time.LocalDateTime
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable

@Observable
class RepoViajes extends CollectionBasedRepo<Viaje> {

	// ********************************************************
	// ** Altas y bajas
	// ********************************************************
	def void create(LocalDateTime vFechaPartida, LocalDateTime vFechaLlegada, Micro vMicro) {
		this.create(new Viaje => [
			fechaPartida = vFechaPartida
			fechaLlegada = vFechaLlegada
			micro = vMicro
		])
	}

	// ********************************************************
	// ** Búsquedas
	// ********************************************************
	def search(String origen, String destino, LocalDateTime fechaPartida, LocalDateTime fechaLlegada) {
		allInstances.filter [ viaje |
			this.match(origen, viaje.origen) && this.match(destino, viaje.destino) &&
				this.match(fechaPartida, viaje.fechaPartida) && this.match(fechaLlegada, viaje.fechaLlegada)
	].toList
	}
	def search(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro) {
		allInstances.filter[viaje|this.match(fechaPartida, viaje.fechaPartida) && this.match(fechaLlegada, viaje.fechaLlegada) && this.match(micro, viaje.micro)].toList
	}
	
	
	def search(String ciudad) {
		allInstances.filter[viaje|this.match(ciudad, viaje.recorrido.contains(ciudad))].toList
	}
	def search(String ciudad,LocalDateTime fechaPartida) {
		allInstances.filter[viaje|this.match(ciudad, viaje.recorrido.contains(ciudad))
		 && this.match(fechaPartida, viaje.fechaPartida)].toList
	}
		def search(String ciudad,LocalDateTime fechaPartida,LocalDateTime fechaLlegada) {
		allInstances.filter[viaje|this.match(ciudad, viaje.recorrido.contains(ciudad))
		 && this.match(fechaPartida, viaje.fechaPartida) && this.match(fechaLlegada, viaje.fechaLlegada)].toList
	}
	def search(Micro micro) {
		allInstances.filter[viaje|this.match(micro, viaje.micro)].toList
	}
	
	def search(double precio, Micro micro) {
		allInstances.filter[viaje|this.match(precio, viaje.precio) && this.match(micro, viaje.micro)].toList
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue === null) {
			return true
		}
		if (realValue === null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}

	override def getEntityType() {
		typeof(Viaje)
	}

	override def createExample() {
		new Viaje
	}

	override protected getCriterio(Viaje example) {
		null
	}
}
