import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*
import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje

class ClienteTest extends ViajeTest {

	Cliente lucas
	Viaje viaje

	@Before
	override void init() {
		super.init
		lucas = new Cliente("Lucas", "Piergiacomi", "11111", "lg.piergiacomi@gmail.com", "44445555")
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
	}

	@Test
	def inicializacionCliente() {
		assertEquals(lucas.apellido, "Piergiacomi")
		assertEquals(lucas.dni, "11111")
	}


}
