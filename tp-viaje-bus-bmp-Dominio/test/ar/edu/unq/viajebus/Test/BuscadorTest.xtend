package ar.edu.unq.viajebus.Test

import ar.edu.unq.viajebus.Buscador.Buscador
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import org.joda.time.LocalDateTime
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*

class BuscadorTest extends ViajeTest {

	Buscador buscador
	LocalDateTime fecha
	Viaje viajeQueNoPaso
	Pasaje pasajeQueNoPaso

	@Before
	override void init() {
		super.init
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		viaje.agregarCiudad("Buenos Aires")
		viaje.agregarCiudad("Rio de Janeiro")
		viajesTest = newArrayList
		pasajesTest = newArrayList
		pasaje = new Pasaje(lucas, viaje, 1)
		pasajesTest.add(pasaje)
		viajesTest.add(viaje)
		viajeQueNoPaso = new Viaje(fechaPartida3, fechaLlegada3, microCama)
		pasajeQueNoPaso = new Pasaje(lucas, viajeQueNoPaso, 1)
		viajesTest.add(viajeQueNoPaso)
		pasajesTest.add(pasajeQueNoPaso)
		buscador = new Buscador => [
			viajes = viajesTest
			pasajes = pasajesTest
		]
	}

	@Test
	def buscarViajePorCiudad() {
		assertEquals(buscador.buscarViajePorCiudad("Buenos Aires").get(0), viaje)
	}

	@Test
	def buscarViajePorFechaPartida() {
		fecha = new LocalDateTime(2018, 03, 30, 12, 00)
		assertEquals(buscador.buscarViajePorFechaPartida(fecha).get(0), viaje)
	}

	@Test
	def buscarViajePorFechaLlegada() {
		fecha = new LocalDateTime(2018, 03, 30, 14, 00)
		assertEquals(buscador.buscarViajePorFechaLlegada(fecha).get(0), viaje)
	}

	@Test
	def buscarViajesQueNoPasaron() {
		assertEquals(buscador.buscarViajesQueNoPasaron.size, 1)
		assertEquals(buscador.buscarViajesQueNoPasaron.get(0), viajeQueNoPaso)
	}

	@Test
	def buscarPasajeQueNoPasaron() {
		assertEquals(buscador.buscarPasajesQueNoPasaron.size, 1)
		assertEquals(buscador.buscarPasajesQueNoPasaron.get(0), pasajeQueNoPaso)
	}
}
