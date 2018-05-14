package ar.edu.unq.viajebus.Test

import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*
import ar.edu.unq.viajebus.TipoAsiento.Ejecutivo
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Asiento

class MicroTest {

	Micro microEjecutivo

	@Before
	def void init() {
		microEjecutivo = new Micro("ABC123", new Ejecutivo, true)
	// microEjecutivo.agregarAsiento(new Asiento)
	}

	@Test
	def inicializacionMicro() {
		assertEquals(microEjecutivo.patente, "ABC123")
		assertTrue(microEjecutivo.tipoDeAsiento instanceof Ejecutivo)
		assertTrue(microEjecutivo.tieneTele)
	}
//	
//	@Test
//	def agregarAsientoAMicro(){
//		assertEquals(microEjecutivo.asientos.size, 1)
//		microEjecutivo.agregarAsiento(new Asiento)
//		assertEquals(microEjecutivo.asientos.size, 2)
//		assertEquals(microEjecutivo.asientos.get(0).numero, 1)
//		assertEquals(microEjecutivo.asientos.get(1).numero, 2)
//	}
//	
//	@Test
//	def asientosDisponiblesDeUnMicro(){
//		assertEquals(microEjecutivo.asientosDisponibles.size(), 1)
//		assertEquals(microEjecutivo.asientosReservados.size(), 0)
//		microEjecutivo.reservarAsiento(1)
//		assertEquals(microEjecutivo.asientosDisponibles.size(), 0)
//		assertEquals(microEjecutivo.asientosReservados.size(), 1)
//		
//	}
}
