package ar.edu.unq.viajebus.Servicios

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
abstract class Servicio {
	double precio
	String nombre

}
