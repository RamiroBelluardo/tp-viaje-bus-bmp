package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.Cliente.Cliente
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.EstadoDePasaje.EstadoDePasaje
import ar.edu.unq.viajebus.EstadoDePasaje.Cancelado
import ar.edu.unq.viajebus.EstadoDePasaje.Confirmado
import ar.edu.unq.viajebus.EstadoDePasaje.ListoParaComprar
import ar.edu.unq.viajebus.Mailing.GMailSender

@Accessors
class Pasaje {

	Cliente cliente
	Viaje viaje
	Asiento asiento
	EstadoDePasaje estado

	new(Cliente cliente, Viaje viaje, Integer nroAsiento) {
		this.cliente = cliente
		cliente.pasajes.add(this)
		this.viaje = viaje
		this.asiento = viaje.micro.asiento(nroAsiento)
		this.estado = new ListoParaComprar
	}

	def cancelar() {
		this.estado.anterior(this)
		this.viaje.micro.liberarAsiento(this.asiento.numero)

	}

	def confirmar() {
		this.estado.siguiente(this)
		this.viaje.micro.reservar(this.asiento.numero)
	}

}
