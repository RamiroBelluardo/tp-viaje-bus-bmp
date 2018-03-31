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
	Asiento asiento1
	Asiento asiento2
	Asiento asiento3
	@Before
	def void init() {
		asiento1= new Asiento
		asiento2=new Asiento
		asiento3=new Asiento
		asiento3.setDisponibilidad(false)
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00)
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		micro = new Micro("AAA111", new Cama, false)
		micro.agregarAsiento(asiento1)
		micro.agregarAsiento(asiento2)
		micro.agregarAsiento(asiento3)
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
	
	@Test
	
	def verCantidadDeAsientosDisponibles(){
		assertEquals(viaje.verAsientosDisponibles.size(),2,0)
		assertFalse(viaje.verAsientosDisponibles.size ==3)
	}
}
