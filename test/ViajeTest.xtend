import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*

class ViajeTest {

	public Viaje viaje
	Viaje viaje2
	LocalDateTime fechaPartida
	LocalDateTime fechaPartida2
	LocalDateTime fechaLlegada
	LocalDateTime fechaLlegada2
	Micro micro
	List<Servicio> servicios
	List<String> recorrido
	Asiento asiento1
	Asiento asiento2
	Asiento asiento3
	public List<Viaje> viajesTest

	@Before
	def void init() {
		asiento1 = new Asiento
		asiento2 = new Asiento
		asiento3 = new Asiento => [
			disponibilidad = false;
		]
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00) // Viernes
		fechaPartida2 = new LocalDateTime(2018, 03, 31, 12, 00) // Sabado
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		fechaLlegada2 = new LocalDateTime(2018, 03, 31, 14, 00)
		micro = new Micro("AAA111", new Cama, false)
		micro.agregarAsiento(asiento1)
		micro.agregarAsiento(asiento2)
		micro.agregarAsiento(asiento3)
		servicios = newArrayList
		servicios.add(new Almuerzo)
		servicios.add(new Merienda)
		recorrido = newArrayList
		recorrido.add("Buenos Aires")
		recorrido.add("Rio de Janeiro")
		viaje = new Viaje(fechaPartida, fechaLlegada, micro, servicios, recorrido)
		viaje2 = new Viaje(fechaPartida2, fechaLlegada2, micro, servicios, recorrido)
		viajesTest = newArrayList
		viajesTest.add(viaje)
	// viajes.add(viaje2)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeAlmuerzoYMeriendaTipoDeAsientoCamaYNoViajaFinde() {
		// 120 min * 2 = $240
		// tiene almuerzo y merienda = 240 + 50 + 30 = $320
		// 10% mas por ser cama = $352
		// no viaja finde
		assertTrue(viaje.precio == 352)
	// assertEquals(viaje.precio, 352.0, 0.0) Se puede testear con assertEquals para que diga que esperaba, pero hay que ponerlo
	// de esta manera.										 
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeAlmuerzoYMeriendaTipoDeAsientoCamaYViajaFinde() {
		// 120 min * 2 = $240
		// tiene almuerzo y merienda = 240 + 50 + 30 = $320
		// 10% mas por ser cama = $352
		// 10% mas por viajar finde = 387.2
		assertTrue(viaje2.precio == 387.2)
	// assertEquals(viaje2.precio, 387.2, 0.0) Se puede testear con assertEquals para que diga que esperaba, pero hay que ponerlo
	// de esta manera.										 
	}

	@Test
	def verCantidadDeAsientosDisponibles() {
		assertEquals(viaje.verAsientosDisponibles.size(), 2, 0)
		assertFalse(viaje.verAsientosDisponibles.size == 3)
	}
}
