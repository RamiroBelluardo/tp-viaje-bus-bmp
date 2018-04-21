package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado
import ar.edu.unq.viajebus.TipoAsiento.TipoAsiento
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class Micro extends Entity implements Cloneable {

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

	new() {
		this.asientos = newArrayList
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

	def buscarAsiento(Integer nro) {
		asientos.filter[asiento|asiento.numero == nro].get(0)
	}

	def reservarAsiento(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).reservar
	}

	def liberarAsiento(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).liberar
	}

	def porcentajeVendido() {
		if (asientos.size == 0) {
			return 0
		} else {
			asientosReservados.size * 100 / asientos.size
		}
	}

}
