package ar.edu.unq.viajebus.runnable

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Asiento
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
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
import repo.RepoViajes

class ViajeBusBootstrap extends CollectionBasedBootstrap {

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Viaje), new RepoViajes)
		ApplicationContext.instance.configureSingleton(typeof(Micro), new RepoMicros)
		ApplicationContext.instance.configureSingleton(typeof(Cliente), new RepoClientes)
		ApplicationContext.instance.configureSingleton(typeof(Pasaje), new RepoPasajes)
	}

	/**
	 * Inicializaci�n del juego de datos del repositorio
	 * 
	 */
	override run() {
		val RepoViajes repoViajes = ApplicationContext.instance.getSingleton(typeof(Viaje))
		val RepoMicros repoMicros = ApplicationContext.instance.getSingleton(typeof(Micro))
		val RepoClientes repoClientes = ApplicationContext.instance.getSingleton(typeof(Cliente))
		val RepoPasajes repoPasajes = ApplicationContext.instance.getSingleton(typeof(Pasaje))

		val partidaMicro1 = new LocalDateTime(2018, 3, 31, 12, 00)
		val llegadaMicro1 = new LocalDateTime(2018, 3, 31, 14, 00)
		val partidaMicro2 = new LocalDateTime(2018, 1, 1, 00, 00)
		val llegadaMicro2 = new LocalDateTime(2018, 1, 2, 00, 00)
		val partidaMicro3 = new LocalDateTime(2018, 2, 22, 17, 20)
		val llegadaMicro3 = new LocalDateTime(2018, 2, 23, 15, 45)


		val micro1 = repoMicros.create("ABC123", new Cama, true)
		val micro2 = repoMicros.create("AB123AB", new Semicama, false)
		val micro3 = repoMicros.create("DCR283", new Ejecutivo, true)

		val asiento1 = new Asiento
		val asiento2 = new Asiento
		val asiento3 = new Asiento

		repoViajes.create(partidaMicro1,llegadaMicro1,micro1)
		repoViajes.create(partidaMicro2,llegadaMicro2,micro2)
		repoViajes.create(partidaMicro3, llegadaMicro3, micro3)
		
		val viaje1 = repoViajes.searchById(1)
		val viaje2 = repoViajes.searchById(2)
		val viaje3 = repoViajes.searchById(3)
		
		viaje1.agregarCiudad("San Salvador de Jujuy")
		viaje2.agregarCiudad("Purmamarca")
		viaje3.agregarCiudad("Tilcara")
		
		val cliente1 = repoClientes.create("Lucas", "Pier", "111111", "lg.piergiacomi@gmail.com", "44444444")

		val pasaje1 = repoPasajes.create(cliente1, viaje1, 1)
		val pasaje2 = repoPasajes.create(cliente1, viaje1, 18)

		micro1.agregarAsiento(asiento1)
		micro1.reservarAsiento(1)
		micro2.agregarAsiento(asiento2)
		micro2.agregarAsiento(asiento3)
		micro2.reservarAsiento(1)
		
		viaje1.agregarServicio(new Desayuno)	
	}

}
