package applicationModel

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Asiento
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoViajes
import org.uqbar.commons.model.Entity
import repo.RepoPasajes

@Accessors
@TransactionalAndObservable
class PasajeAppModel extends Entity implements Cloneable {
	Cliente clienteSeleccionado
	Cliente exampleCliente = new Cliente
	List<Cliente> resultadosClientes

	Viaje viajeSeleccionado = repoViajes.searchById(2)
	Micro microSeleccionado = viajeSeleccionado.micro 
	Pasaje pasajeSeleccionado

	// Micro exampleMicro = repoMicros.micros.get(1)
	// Viaje viajeSeleccionado = repoViajes.searchById(1)
	Integer nroAsientoSeleccionado


	def search() {
		resultadosClientes = repoClientes.allInstances
	}

	def RepoMicros getRepoMicros() {
		ApplicationContext.instance.getSingleton(Micro) as RepoMicros
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}

	def RepoClientes getRepoClientes() {
		ApplicationContext.instance.getSingleton(typeof(Cliente))
	}
		def RepoPasajes getRepoPasajes() {
		ApplicationContext.instance.getSingleton(typeof(Pasaje))
	}

	def actualizarViajeSeleccionado(Viaje viaje) {
		viajeSeleccionado = viaje
		repoViajes.update(viaje)
		search
	}
	
	def actualizarPasajeYViajeSeleccionado(Pasaje pasaje, Viaje viaje) {
		pasajeSeleccionado = pasaje
		viajeSeleccionado = viaje
		repoPasajes.update(pasaje)
		repoViajes.update(viaje)
		search
	}
	
//	def actualizarPasaje(Pasaje pasaje) {
//		microSeleccionado= pasaje.viaje.micro
//		viajeSeleccionado=pasaje.viaje
//		repoViajes.update(pasaje.viaje)
//		pasajeSeleccionado = pasaje
//		repoPasajes.update(pasaje)
//		search
//	}

	def crearCliente(Cliente cliente) {
		repoClientes.create(cliente)
		search
	}

}
