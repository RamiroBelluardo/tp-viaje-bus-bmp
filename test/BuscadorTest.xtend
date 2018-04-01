import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*

class BuscadorTest extends ViajeTest {

	Buscador buscador

	@Before
	override void init() {
		super.init
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
		assertEquals(buscador.buscarViajePorFechaPartida(fechaPartida).get(0), viaje)
	}

	@Test
	def buscarViajePorFechaLlegada() {
		assertEquals(buscador.buscarViajePorFechaLlegada(fechaLlegada).get(0), viaje)
	}

}
