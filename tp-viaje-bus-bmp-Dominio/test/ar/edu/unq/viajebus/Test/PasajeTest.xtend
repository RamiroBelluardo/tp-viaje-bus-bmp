package ar.edu.unq.viajebus.Test

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Viaje
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Asiento
import org.joda.time.LocalDateTime
import ar.edu.unq.viajebus.TipoAsiento.Cama
import org.mockito.Mock
import ar.edu.unq.viajebus.Mailing.GMailSender
import org.mockito.MockitoAnnotations

import static org.mockito.Mockito.*
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado
import ar.edu.unq.viajebus.EstadoDePasaje.Cancelado
import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.EstadoDePasaje.Confirmado
import ar.edu.unq.viajebus.EstadoDePasaje.ListoParaComprar
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible

class PasajeTest {

	Cliente lucas
	Viaje viaje
	Pasaje pasaje
	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro microCama
	Asiento asiento1
	@Mock GMailSender notificador

	@Before
	def void init() {
		MockitoAnnotations.initMocks(this)
		GMailSender.config(notificador)
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00)
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		asiento1 = new Asiento()
		microCama = new Micro("AAA111", new Cama, false, 20)
		// microCama.agregarAsiento(asiento1)
		lucas = new Cliente("Lucas", "Piergiacomi", "11.111.111", "lg.piergiacomi@gmail.com", "44445555")
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		viaje.agregarAsiento(asiento1)
		pasaje = new Pasaje(lucas, viaje, 1)
	}

	@Test
	def inicializacionPasaje() {
		assertEquals(pasaje.cliente.nombre, "Lucas")
		assertEquals(pasaje.cliente.dni, "11.111.111")
		assertEquals(pasaje.viaje.micro, microCama)
		assertEquals(pasaje.asiento.numero, 1)
		assertEquals(pasaje.estado.class, ListoParaComprar)
		assertEquals(pasaje.tipoPago, "Efectivo")
	}

	@Test
	def cantidadDePasajesDeUnCliente() {
		assertEquals(lucas.pasajes.size(), 1)
		assertTrue(lucas.pasajes.contains(pasaje))
	}

	@Test
	def confirmarPasaje() {
		assertEquals(pasaje.estado.class, ListoParaComprar)
		assertTrue(pasaje.viaje.estaDisponibleElNro(1))
		pasaje.confirmar
		// Manda mail de confirmacion:
		verify(notificador, times(1)).notificarCompraDePasaje(pasaje)
		// El Pasaje pasa de ListoParaComprar a Confirmado:
		assertEquals(pasaje.estado.class, Confirmado)
		// El Asiento pasa de Disponible a Reservado:
		assertEquals(pasaje.asiento.estado.class, Reservado)
		assertFalse(pasaje.viaje.estaDisponibleElNro(1))

	}

	@Test
	def cancelarPasaje() {
		assertEquals(pasaje.estado.class, ListoParaComprar)
		assertTrue(pasaje.viaje.estaDisponibleElNro(1))
		pasaje.confirmar
		// El Pasaje pasa de ListoParaComprar a Confirmado:
		assertEquals(pasaje.estado.class, Confirmado)
		assertFalse(pasaje.viaje.estaDisponibleElNro(1))
		pasaje.cancelar
		// Manda mail de cancelaci�n:
		verify(notificador, times(1)).notificarCancelacionDePasaje(pasaje)
		// El Pasaje pasa de Confirmado a Cancelado:
		assertEquals(pasaje.estado.class, Cancelado)
		// El Asiento pasa de Reservado a Disponible:
		assertEquals(pasaje.asiento.estado.class, Disponible)
		assertTrue(pasaje.viaje.estaDisponibleElNro(1))
	}

	@Test(expected=UserException)
	def confirmarPasajeYaConfirmado() {
		pasaje.confirmar
		pasaje.confirmar
	}

	@Test(expected=UserException)
	def cancelarPasajeYaCancelado() {
		pasaje.cancelar
		pasaje.cancelar
	}

}
