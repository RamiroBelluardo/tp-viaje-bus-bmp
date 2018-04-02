import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import org.joda.time.LocalDateTime

class BuscadorTest extends ViajeTest {

	Buscador buscador
	LocalDateTime fecha

	@Before
	override void init() {
		super.init
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		viaje.agregarCiudad("Buenos Aires")
		viaje.agregarCiudad("Rio de Janeiro")
		viajesTest = newArrayList
		viajesTest.add(viaje)
		buscador = new Buscador => [
			viajes = viajesTest
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

}
