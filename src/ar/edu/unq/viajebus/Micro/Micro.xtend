package ar.edu.unq.viajebus.Micro

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado

@Accessors
class Micro {

	String patente
	List<Asiento> asientos
	TipoAsiento tipoDeAsiento
	Boolean tieneTele

	new(String patente, TipoAsiento tipoAsiento, Boolean tieneTele) {
		this.patente = patente
		this.asientos = newArrayList
		this.tipoDeAsiento = tipoAsiento
		this.tieneTele = tieneTele
	}

	def agregarAsiento(Asiento asiento) {
		asiento.numero = asientos.size + 1
		asientos.add(asiento)
	}

	def asientosDisponibles() {
		asientos.filter[asiento|asiento.estado instanceof Disponible]
	}

	def asientosReservados() {
		asientos.filter[asiento|asiento.estado instanceof Reservado]
	}

	def estaDisponibleElNro(Integer nro) {
		asientos.filter[asiento|asiento.numero == nro].get(0).estado instanceof Disponible
	}

	def asiento(Integer nro) {
		asientos.filter[asiento|asiento.numero == nro].get(0)
	}

	def reservar(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).reservar
	}

	def liberarAsiento(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).liberar
	}

}
