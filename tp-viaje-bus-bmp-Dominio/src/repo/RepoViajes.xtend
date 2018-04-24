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
