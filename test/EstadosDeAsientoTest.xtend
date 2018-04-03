import ar.edu.unq.viajebus.Micro.Asiento
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado
import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible

class EstadosDeAsientoTest {
	Asiento asiento

	@Before
	def void init() {
		asiento = new Asiento()
	}
	
	@Test
	def void reservarUnAsientoDisponible(){
		asiento.reservar
		assertTrue(asiento.estado instanceof Reservado)
	} 
	
	@Test (expected = UserException)
	def void reservarUnAsientoYaReservado(){
		asiento.reservar
		asiento.reservar
	}
	
	@Test
	def void liberarAsientoReservado(){
		asiento.reservar
		assertTrue(asiento.estado instanceof Reservado)
		asiento.liberar
		assertTrue(asiento.estado instanceof Disponible)
	}
	
	@Test (expected = UserException)
	def void liberarAsientoDisponible() {
		asiento.liberar
	}

}
