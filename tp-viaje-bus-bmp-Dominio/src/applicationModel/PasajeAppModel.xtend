package applicationModel

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoPasajes
import repo.RepoViajes

@Accessors
@TransactionalAndObservable
class PasajeAppModel extends Entity implements Cloneable {
	Cliente clienteSeleccionado

	List<Cliente> resultadosClientes
	List<Pasaje> resultadosPasajes
	List<Viaje> resultadosViajes
	List<Micro> resultadosMicros

	Viaje viajeSeleccionado
	Micro microSeleccionado = new Micro
	Pasaje pasajeSeleccionado
	Integer nroAsiento

	def search() {
		resultadosClientes = repoClientes.allInstances.toList
	}

	def RepoMicros getRepoMicros() {
		ApplicationContext.instance.getSingleton(typeof(Micro))
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

	def crearCliente(Cliente cliente) {
		repoClientes.create(cliente)
		search
	}

}
