package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.EstadoDePasaje.EstadoDePasaje
import ar.edu.unq.viajebus.EstadoDePasaje.ListoParaComprar
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class Pasaje extends Entity implements Cloneable {

	Cliente cliente
	Viaje viaje
	Integer nroAsiento
	Asiento asiento
	EstadoDePasaje estado
	String tipoPago

	new(Cliente cliente, Viaje viaje, Integer nroAsiento) {
		this.cliente = cliente
		cliente.pasajes.add(this)
		this.viaje = viaje
		this.nroAsiento = nroAsiento
		this.asiento = viaje.buscarAsiento(nroAsiento)
		this.estado = new ListoParaComprar
		this.tipoPago = "Efectivo"
	}

	new() {
		this.cliente = cliente
		this.viaje = viaje
		this.nroAsiento = nroAsiento
		this.estado = new ListoParaComprar
		this.tipoPago = "Efectivo"

	}

	def cancelar() {
		this.viaje.pasajes.remove(this)
		this.estado.anterior(this)
		this.viaje.liberarAsiento(this.asiento.numero)

	}

	def confirmar() {
		this.viaje.pasajes.add(this)
		this.estado.siguiente(this)
		this.viaje.reservarAsiento(this.asiento.numero)
	}

	def getNoTieneCliente() {
		this.cliente === null
	}

//	def Integer getNroAsiento() {
//		nroAsiento
//	}
//
//	def void setNroAsiento(Integer nro) {
//		this.nroAsiento = nro
//	}
}
