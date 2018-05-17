package repo

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable

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
		allInstances.filter [ pasaje |
			this.match(id, pasaje.id)].toList
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
