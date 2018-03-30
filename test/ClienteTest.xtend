

import org.junit.Test
import org.junit.Before
import static org.junit.Assert.*


class ClienteTest {
	
	Cliente lucas
	
	@Before
	def void init(){
		lucas = new Cliente("Lucas","Piergiacomi","11111","lg.piergiacomi@gmail.com","44445555")
	}
	
	
	@Test
	def inicializacionCliente(){
		assertEquals(lucas.apellido, "Piergiacomi")
		assertEquals(lucas.dni, "11111")
	}
	
}