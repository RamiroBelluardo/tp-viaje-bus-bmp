package repo

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import org.joda.time.LocalDate
import org.joda.time.LocalDateTime
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import java.util.Date

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
	def search(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro) {
		allInstances.filter [ viaje |
			this.match(fechaPartida, viaje.fechaPartida) && this.match(fechaLlegada, viaje.fechaLlegada) &&
				this.match(micro, viaje.micro)
		].toList
	}

	def search(String ciudad, LocalDate fechaPartida, LocalDate fechaLlegada) {
		allInstances.filter [ viajes |
			this.match(ciudad, viajes.recorrido) && this.match(fechaPartida, viajes.fechaPartida.toLocalDate) &&
				this.match(fechaLlegada, viajes.fechaLlegada.toLocalDate)
		].toList
	}
	
	def search(String ciudadPartida, String ciudadLlegada) {
		allInstances.filter [ viajes |
			this.match(ciudadPartida, viajes.recorrido.head) && this.match(ciudadLlegada, viajes.recorrido.last)].toList
	}
	

	def search(String ciudadPartida, String ciudadLlegada, LocalDate fechaPartida, LocalDate fechaLlegada) {
		val hoy = LocalDateTime.now
		allInstances.filter [ viajes |
			this.match(ciudadPartida, viajes.recorrido.head) && this.match(ciudadLlegada, viajes.recorrido.last) &&
				this.match(fechaPartida, viajes.fechaPartida.toLocalDate) &&
				this.match(fechaLlegada, viajes.fechaLlegada.toLocalDate) && viajes.fechaPartida.isAfter(hoy)
		].toList
	}
	
	def searchActuales() {
		val fechaPartida = LocalDateTime.now
		allInstances.filter [ viaje | viaje.fechaPartida.isAfter(fechaPartida) || viaje.fechaPartida.isEqual(fechaPartida)].toList
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

	def getViajes() {
		allInstances
	}
}
