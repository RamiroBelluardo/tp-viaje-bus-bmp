import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*

class ViajeTest {

	Viaje viaje
	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios

	@Before
	def void init() {
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00)
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		micro = new Micro("AAA111", new Cama, false)
		servicios = newArrayList
		servicios.add(new Almuerzo)
		servicios.add(new Merienda)
		viaje = new Viaje(fechaPartida, fechaLlegada, micro, servicios)
	}

	@Test
	def calcularPrecioDeUnViaje() {
		// 120 min * 2 = $240
		// tiene almuerzo y merienda = 240 + 50 + 30 = $320
		// 10% mas por ser cama = $352
		// no viaja finde
		assertTrue(viaje.precio == 352)
	// assertEquals(viaje.precio, 352.0, 0.0) Se puede testear con assertEquals para que diga que esperaba, pero hay que ponerlo
	// de esta manera.										 
	}
}
