package repo

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable

@Observable
class RepoMicros extends CollectionBasedRepo<Micro> {

	// ********************************************************
	// ** Altas y bajas
	// ********************************************************
	def Micro create(String mPatente, TipoAsiento mTipoDeAsiento, Boolean mTieneTele) {
		val micro = new Micro => [
			patente = mPatente
			tipoDeAsiento = mTipoDeAsiento
			tieneTele = mTieneTele
		]
		this.create(micro)
		micro
	}
	
	override protected getCriterio(Micro example) {
		null
	}
	
	override createExample() {
		new Micro
	}
	
	override getEntityType() {
		typeof(Micro)
	}
	
	def search() {
		allInstances
	}

}


