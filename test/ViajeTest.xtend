import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.Micro.*
import ar.edu.unq.viajebus.Servicios.*
import ar.edu.unq.viajebus.TipoAsiento.*
import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.EstadoDePasaje.ListoParaComprar
import org.mockito.Mock
import ar.edu.unq.viajebus.Mailing.GMailSender
import org.mockito.MockitoAnnotations
import ar.edu.unq.viajebus.EstadoDePasaje.Cancelado
import EstadoDeViaje.Eliminado
import ar.edu.unq.viajebus.EstadoDePasaje.Confirmado
import EstadoDeViaje.Aprobado
import EstadoDeViaje.ViajeCancelado
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class ViajeTest {
	
	Viaje viaje
	Viaje viajeFinde
	Viaje viajeQueNoPaso
	LocalDateTime fechaPartida
	LocalDateTime fechaPartida2
	LocalDateTime fechaPartida3
	LocalDateTime fechaLlegada
	LocalDateTime fechaLlegada2
	LocalDateTime fechaLlegada3
	Micro microCama
	Micro microEjecutivo
	Micro microSemicama
	Asiento asiento1
	Asiento asiento2
	Asiento asiento3
	List<Viaje> viajesTest
	Pasaje pasaje
	Cliente lucas
	@Mock GMailSender notificador

	@Before
	def void init() {
		MockitoAnnotations.initMocks(this)
		GMailSender.config(notificador)
		asiento1 = new Asiento
		asiento2 = new Asiento
		asiento3 = new Asiento
		fechaPartida = new LocalDateTime(2018, 03, 30, 12, 00) // Viernes
		fechaPartida2 = new LocalDateTime(2018, 03, 31, 12, 00) // Sabado
		fechaPartida3 = new LocalDateTime(2018, 07, 05, 10, 00)
		fechaLlegada = new LocalDateTime(2018, 03, 30, 14, 00)
		fechaLlegada2 = new LocalDateTime(2018, 03, 31, 14, 00)
		fechaLlegada3 = new LocalDateTime(2018, 12, 13, 14, 00)
		microCama = new Micro("AAA111", new Cama, false)
		microCama.agregarAsiento(asiento1)
		microCama.agregarAsiento(asiento2)
		microCama.agregarAsiento(asiento3)
		microEjecutivo = new Micro("BBB222", new Ejecutivo, false)
		microSemicama = new Micro("AB123AB", new Semicama, true)
		lucas = new Cliente("Lucas", "Piergiacomi", "11.111.111", "lg.piergiacomi@gmail.com", "44445555")
	}

	@Test
	def calcularPrecioDeUnViajeSinServiciosTipoDeAsientoCamaYNoViajaFinde() {
		// 120 min * 2 = $240
		// No tiene servicios
		// 10% m�s por ser cama = $264
		// No viaja fin de semana 
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		assertTrue(viaje.precio == 264)
	}

	@Test
	def calcularPrecioDeUnViajeSinServiciosTipoDeAsientoEjecutivoYNoViajaFinde() {
		// 120 min * 2 = $240
		// No tiene servicios
		// 20% m�s por ser ejecutivo = $288
		// No viaja fin de semana 
		viaje = new Viaje(fechaPartida, fechaLlegada, microEjecutivo)
		assertTrue(viaje.precio == 288)
	}

	@Test
	def calcularPrecioDeUnViajeSinServiciosTipoDeAsientoSemicamaYNoViajaFinde() {
		// 120 min * 2 = $240
		// No tiene servicios
		// Es semicama (queda igual)
		// No viaja fin de semana 
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		assertTrue(viaje.precio == 240)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeDesayunoYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Desayuno)
		// 120 min * 2 = $240
		// Tiene desayuno = 240 + 30 = $270
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 270)
	// assertEquals(viaje.precio, 270.0, 0.0) Se puede testear con assertEquals para que diga que esperaba, pero hay que ponerlo
	// de esta manera.	
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeAlmuerzoYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Almuerzo)
		// 120 min * 2 = $240
		// Tiene almuerzo = 240 + 50 = $290
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 290)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeMeriendaYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Merienda)
		// 120 min * 2 = $240
		// Tiene merienda = 240 + 30 = $270
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 270)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeCenaYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Cena)
		// 120 min * 2 = $240
		// Tiene cena = 240 + 50 = $290
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 290)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeAlmuerzoYCenaYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Almuerzo)
		viaje.agregarServicio(new Cena)
		// 120 min * 2 = $240
		// Tiene almuerzo y cena = 240 + 50 = $290
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 290)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeDesayunoYMeriendaYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Desayuno)
		viaje.agregarServicio(new Merienda)
		// 120 min * 2 = $240
		// Tiene almuerzo y cena = 240 + 30 = $270
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 270)
	}

	@Test
	def agregarElMismoServicio2Veces() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Desayuno)
		viaje.agregarServicio(new Desayuno)
		assertEquals(viaje.servicios.size, 1)
	}

	@Test
	def calcularPrecioDeUnViajeConServicioDeMeriendaYCenaYNoViajaFinde() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microSemicama)
		viaje.agregarServicio(new Merienda)
		viaje.agregarServicio(new Cena)
		// 120 min * 2 = $240
		// Tiene merienda cena = 240 + 30 + 50 = $320
		// Es semicama (queda igual)
		// No viaja fin de semana 
		assertTrue(viaje.precio == 320)
	}

	@Test
	def calcularPrecioDeDosViajesConServicioDeMeriendaPeroDistintoTipoDeAsiento() {
		var viajeCama = new Viaje(fechaPartida, fechaLlegada, microCama)
		var viajeEjecutivo = new Viaje(fechaPartida, fechaLlegada, microEjecutivo)
		viajeCama.agregarServicio(new Merienda)
		viajeEjecutivo.agregarServicio(new Merienda)
		// Viaje Cama: $240 + $30 + %10
		// Viaje Ejecutivo: $240 + $30 + %20
		assertTrue(viajeCama.precio == 297)
		assertTrue(viajeEjecutivo.precio == 324)
	}

	@Test
	def verificarSiUnViajeOcurreEnFinDeSemana() {
		viajeFinde = new Viaje(fechaPartida2, fechaLlegada2, microCama)
		assertTrue(viajeFinde.esFinde())
	}

	@Test
	def calcularPrecioDeDosViajesIdenticosExceptoViajarFinDeSemana() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		viajeFinde = new Viaje(fechaPartida2, fechaLlegada2, microCama)
		assertTrue(viaje.precio == 264)
		assertTrue(viajeFinde.precio == 290.4)
	}

	@Test
	def verCantidadDeAsientosDisponibles() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		assertEquals(viaje.verAsientosDisponibles.size(), 3)
	}

	@Test
	def verCantidadDeAsientosReservados() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		assertEquals(viaje.verAsientosReservados.size(), 0)
		assertEquals(viaje.verAsientosDisponibles.size(), 3)
		viaje.micro.reservar(3)
		assertEquals(viaje.verAsientosReservados.size(), 1)
		assertEquals(viaje.verAsientosDisponibles.size(), 2)
	}

	@Test
	def alComprarPasajeSeAgregaAlViaje() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		pasaje = new Pasaje(lucas, viaje, 1)
		assertEquals(viaje.pasajes.size, 0)
		pasaje.confirmar
		assertEquals(viaje.pasajes.get(0), pasaje)
	}

	@Test
	def cancelarViajeSinPasaje() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		assertEquals(viaje.estado.class, Aprobado)
		viaje.cancelar
		assertEquals(viaje.estado.class, ViajeCancelado)
	}

	@Test
	def cancelarViajeConPasaje() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		pasaje = new Pasaje(lucas, viaje, 1)
		assertEquals(viaje.estado.class, Aprobado)
		pasaje.confirmar
		assertEquals(viaje.pasajes.get(0).estado.class, Confirmado)
		viaje.cancelar
		assertEquals(viaje.estado.class, ViajeCancelado)
		assertEquals(viaje.pasajes.get(0).estado.class, Cancelado)
	}

	@Test
	def eliminarViajeSinPasaje() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		viaje.eliminar
		assertEquals(viaje.estado.class, Eliminado)
	}

	@Test(expected=UserException)
	def void eliminarViajeConPasaje() {
		viaje = new Viaje(fechaPartida, fechaLlegada, microCama)
		pasaje = new Pasaje(lucas, viaje, 1)
		pasaje.confirmar
		viaje.eliminar
	}

}
