package ar.edu.unq.viajebus.runnable

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Cliente.Usuario
import ar.edu.unq.viajebus.Mailing.GMailSender
import ar.edu.unq.viajebus.Micro.Asiento
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Servicios.Cena
import ar.edu.unq.viajebus.Servicios.Desayuno
import ar.edu.unq.viajebus.TipoAsiento.Cama
import ar.edu.unq.viajebus.TipoAsiento.Ejecutivo
import ar.edu.unq.viajebus.TipoAsiento.Semicama
import org.joda.time.LocalDateTime
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoPasajes
import repo.RepoUsuarios
import repo.RepoViajes

class ViajeBusBootstrap extends CollectionBasedBootstrap {

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Viaje), new RepoViajes)
		ApplicationContext.instance.configureSingleton(typeof(Micro), new RepoMicros)
		ApplicationContext.instance.configureSingleton(typeof(Cliente), new RepoClientes)
		ApplicationContext.instance.configureSingleton(typeof(Pasaje), new RepoPasajes)
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepoUsuarios)
	}

	/**
	 * Inicializaci�n del juego de datos del repositorio
	 * 
	 */
	override run() {
		GMailSender.config(new GMailSender("pruebasfacultadtpi@gmail.com", "unqui2017"))

		val RepoViajes repoViajes = ApplicationContext.instance.getSingleton(typeof(Viaje))
		val RepoMicros repoMicros = ApplicationContext.instance.getSingleton(typeof(Micro))
		val RepoClientes repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente))
		val RepoPasajes repoPasajes = ApplicationContext.instance.getSingleton(typeof(Pasaje))
		val RepoUsuarios repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario))

		val partidaMicro1 = new LocalDateTime(2019, 4, 1, 12, 10)
		val llegadaMicro1 = new LocalDateTime(2019, 4, 1, 14, 20)
		val partidaMicro2 = new LocalDateTime(2020, 1, 1, 01, 13)
		val llegadaMicro2 = new LocalDateTime(2020, 1, 2, 03, 12)
		val partidaMicro3 = new LocalDateTime(2021, 2, 22, 17, 20)
		val llegadaMicro3 = new LocalDateTime(2021, 2, 23, 15, 45)
		// val partidaMicro4 = new LocalDateTime(2025, 4, 12, 13, 00)
		// val llegadaMicro4 = new LocalDateTime(2025, 4, 13, 15, 00)
		val partidaMicro4 = new LocalDateTime()
		val llegadaMicro4 = new LocalDateTime()

		val micro1 = repoMicros.create("ABC123", new Cama, true, 2)
		val micro2 = repoMicros.create("AB123AB", new Semicama, false, 6)
		val micro3 = repoMicros.create("DCR283", new Ejecutivo, true, 0)
		val micro4 = repoMicros.create("XYZ123", new Ejecutivo, true, 8)

		repoViajes.create(partidaMicro1, llegadaMicro1, micro1)
		repoViajes.create(partidaMicro2, llegadaMicro2, micro2)
		repoViajes.create(partidaMicro3, llegadaMicro3, micro3)
		repoViajes.create(partidaMicro4, llegadaMicro4, micro4)

		val viaje1 = repoViajes.searchById(1)
		val viaje2 = repoViajes.searchById(2)
		val viaje3 = repoViajes.searchById(3)
		val viaje4 = repoViajes.searchById(4)

		viaje1.agregarCiudad("San Salvador de Jujuy")
		viaje2.agregarCiudad("Purmamarca")
		viaje2.agregarCiudad("Buenos Aires")
		viaje3.agregarCiudad("Tilcara")
		viaje4.agregarCiudad("Córdoba")
		viaje4.agregarCiudad("San Luis")
		viaje4.agregarCiudad("Formosa")

		val cliente1 = repoClientes.create("Lucas", "Pier", "11111111", "lg.piergiacomi@asd.com", "44444444")
		val cliente2 = repoClientes.create("Esteban", "Matas", "22222222", "esteban@eso.com", "")
		val cliente3 = repoClientes.create("Ramiro", "Belluardo", "33333333", "ramirobelluardo1993@eso.com", "22222222")

		val usuario1 = repoUsuarios.create("lucas", "12345", cliente1)
		val usuario2 = repoUsuarios.create("esteban", "12345", cliente2)
		val usuario3 = repoUsuarios.create("ramiro", "12345", cliente3)

		viaje1.agregarAsiento(new Asiento)
		viaje1.agregarAsiento(new Asiento)

		viaje2.agregarAsiento(new Asiento)
		viaje2.agregarAsiento(new Asiento)
		viaje2.agregarAsiento(new Asiento)
		viaje2.agregarAsiento(new Asiento)
		viaje2.agregarAsiento(new Asiento)
		viaje2.agregarAsiento(new Asiento)

		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)
		viaje4.agregarAsiento(new Asiento)

		viaje1.agregarServicio(new Desayuno)
		viaje4.agregarServicio(new Desayuno)
		viaje4.agregarServicio(new Cena)

		val pasaje1 = repoPasajes.create(cliente1, viaje4, 1)
		//val pasaje2 = repoPasajes.create(cliente2, viaje2, 3)
		//val pasaje3 = repoPasajes.create(cliente1, viaje4, 7)
		// val pasaje3 = repoPasajes.create(cliente3, viaje3, 1)
		pasaje1.confirmar
		//pasaje2.confirmar

	}

}
