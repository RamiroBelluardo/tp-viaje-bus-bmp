package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import org.joda.time.LocalDateTime
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
class RepoPasajes extends CollectionBasedRepo<Pasaje> {

	// ********************************************************
	// ** Altas y bajas
	// ********************************************************
	def Pasaje create(Cliente pCliente, Viaje pViaje, Integer pNroAsiento) {
		val pasaje = new Pasaje => [
			cliente = pCliente
			viaje = pViaje
			nroAsiento = pNroAsiento
			asiento = pViaje.buscarAsiento(pNroAsiento)
		]

		this.create(pasaje)
		pasaje
	}

	def search(Cliente cliente, Viaje viaje, Integer nroAsiento) {
		allInstances.filter [ pasaje |
			this.match(cliente, pasaje.cliente) && this.match(viaje, pasaje.viaje) &&
				this.match(nroAsiento, pasaje.nroAsiento)
		].toList
	}
	
	def search(Integer id) {
		val pasaje = allInstances.findFirst [ pasaje | this.match(id, pasaje.id)]
		if (pasaje === null){
			throw new UserException("No se encontró un pasaje con ese id")
		}
		pasaje
	}
	
	def search(Cliente cliente){
		val fechaLlegada = LocalDateTime.now
		val pasajes = allInstances.filter [pasaje | this.match(cliente, pasaje.cliente) && pasaje.viaje.fechaLlegada.isAfter(fechaLlegada) && pasaje.estado.nombre !== "Cancelado"].toList
		pasajes
	}
	
	def searchHistoricos(Cliente cliente){
		val fechaLlegada = LocalDateTime.now
		val pasajes = allInstances.filter [pasaje | this.match(cliente, pasaje.cliente) && pasaje.viaje.fechaLlegada.isBefore(fechaLlegada)].toList
		pasajes
	}
	
	def searchCancelados(Cliente cliente){
		val pasajes = allInstances.filter [pasaje | this.match(cliente, pasaje.cliente) && pasaje.estado.nombre == "Cancelado"].toList
		pasajes
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

	def pasajes() {
		allInstances
	}

	override getEntityType() {
		typeof(Pasaje)
	}

	override createExample() {
		new Pasaje
	}

	override protected getCriterio(Pasaje example) {
		null
	}
}
