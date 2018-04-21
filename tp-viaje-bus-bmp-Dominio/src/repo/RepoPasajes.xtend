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
			// asiento = pViaje.micro.buscarAsiento(pNroAsiento)
			nroAsiento = pNroAsiento
		]
		this.create(pasaje)
		pasaje
	}

	override protected getCriterio(Pasaje example) {
		null
	}

	override createExample() {
		new Pasaje
	}

	override getEntityType() {
		typeof(Pasaje)
	}

	def search() {
		allInstances
	}

}
