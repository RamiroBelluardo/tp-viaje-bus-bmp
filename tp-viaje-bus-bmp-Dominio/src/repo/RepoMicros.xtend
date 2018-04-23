package repo

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import java.util.List

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

	def getMicros() {
		allInstances
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

}
