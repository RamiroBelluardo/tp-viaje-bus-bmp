package ar.edu.unq.viajebus.EstadoDeViaje

import ar.edu.unq.viajebus.Micro.Viaje

abstract class EstadoDeViaje {

	def void cancelar(Viaje viaje)

	def void eliminar(Viaje viaje)

}
