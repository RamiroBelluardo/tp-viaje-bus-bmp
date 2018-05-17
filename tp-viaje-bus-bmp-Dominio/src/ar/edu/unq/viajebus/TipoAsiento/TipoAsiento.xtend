package ar.edu.unq.viajebus.TipoAsiento

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
abstract class TipoAsiento {
	String nombre
	Integer porcentaje
}
