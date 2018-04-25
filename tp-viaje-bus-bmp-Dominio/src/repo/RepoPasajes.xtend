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
			asiento = pViaje.micro.buscarAsiento(pNroAsiento)
		]
		
		this.create(pasaje)
		pasaje
	}

	def search(Cliente cliente) {
		allInstances.filter[pasaje|this.match(cliente, pasaje.cliente)].toList
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
