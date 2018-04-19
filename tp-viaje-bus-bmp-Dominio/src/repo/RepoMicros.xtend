package repo

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.TipoAsiento.Ejecutivo
import ar.edu.unq.viajebus.TipoAsiento.Semicama
import ar.edu.unq.viajebus.TipoAsiento.Cama

class RepoMicros {

	static RepoMicros instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoMicros
		}
		instance
	}

	// MICRO:    new(String patente, TipoAsiento tipoAsiento, Boolean tieneTele)
	def getMicros() {

		val micro1 = new Micro("ABC123", new Cama, true)
		val micro2 = new Micro("AB123AB", new Semicama, false)
		val micro3 = new Micro("DCR283", new Ejecutivo, true)

		#[micro1, micro2, micro3]
	}

}
