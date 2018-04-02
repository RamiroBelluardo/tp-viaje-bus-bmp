import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*
import ar.edu.unq.viajebus.TipoAsiento.Ejecutivo
import ar.edu.unq.viajebus.Micro.Micro

class MicroTest {

	Micro microEjecutivo

	@Before
	def void init() {
		microEjecutivo = new Micro("ABC123", new Ejecutivo, true)
	}

	@Test
	def inicializacionMicro() {
		assertEquals(microEjecutivo.patente, "ABC123")
		assertTrue(microEjecutivo.tipoDeAsiento instanceof Ejecutivo)
		assertTrue(microEjecutivo.tieneTele)
	}

}
