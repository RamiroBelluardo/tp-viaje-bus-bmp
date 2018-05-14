package ar.edu.unq.viajebus.Test

import ar.edu.unq.viajebus.Micro.Asiento
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado
import org.uqbar.commons.model.exceptions.UserException
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class EstadosDeAsientoTest {
	Asiento asiento

	@Before
	def void init() {
		asiento = new Asiento(1)
	}

	@Test
	def void reservarUnAsientoDisponible() {
		asiento.reservar
		assertTrue(asiento.estado instanceof Reservado)
	}

	@Test(expected=UserException)
	def void reservarUnAsientoYaReservado() {
		asiento.reservar
		asiento.reservar
	}

	@Test
	def void liberarAsientoReservado() {
		asiento.reservar
		assertTrue(asiento.estado instanceof Reservado)
		asiento.liberar
		assertTrue(asiento.estado instanceof Disponible)
	}

	@Test(expected=UserException)
	def void liberarAsientoDisponible() {
		asiento.liberar
	}

}
