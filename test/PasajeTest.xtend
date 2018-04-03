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

class PasajeTest {

	Cliente lucas
	Viaje viaje
	Pasaje pasaje
	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro microCama
	Asiento asiento1

	@Before
	def void init() {
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00)
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		asiento1 = new Asiento
		microCama = new Micro("AAA111", new Cama, false)
		microCama.agregarAsiento(asiento1)
		lucas = new Cliente("Lucas", "Piergiacomi", "11.111.111", "lg.piergiacomi@gmail.com", "44445555")
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		pasaje = new Pasaje(lucas, viaje, 1)
	}

	@Test
	def inicializacionPasaje() {
		assertEquals(pasaje.cliente.nombre, "Lucas")
		assertEquals(pasaje.cliente.dni, "11.111.111")
		assertEquals(pasaje.viaje.micro, microCama)
		assertEquals(pasaje.asiento.numero, 1)
		assertFalse(pasaje.viaje.micro.estaDisponibleElNro(1))
	}
	
	@Test
	def cantidadDePasajesDeUnCliente(){
		assertEquals(lucas.pasajes.size(), 1)
		assertTrue(lucas.pasajes.contains(pasaje))
	}

}
