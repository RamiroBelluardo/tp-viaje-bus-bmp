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
	def Viaje create(LocalDateTime vFechaPartida, LocalDateTime vFechaLlegada, Micro vMicro) {
		val viaje = new Viaje => [
			fechaPartida = vFechaPartida
			fechaLlegada = vFechaLlegada
			micro = vMicro
		]
		this.create(viaje)
		viaje
	}

	// ********************************************************
	// ** B�squedas
	// ********************************************************
	def search(String origen, String destino, LocalDateTime fechaPartida, LocalDateTime fechaLlegada) {
		allInstances.filter [ viaje |
			this.match(origen, viaje.getOrigen) && this.match(destino, viaje.getDestino) &&
				this.match(fechaPartida, viaje.fechaPartida) && this.match(fechaLlegada, viaje.fechaLlegada)
		].toList
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
