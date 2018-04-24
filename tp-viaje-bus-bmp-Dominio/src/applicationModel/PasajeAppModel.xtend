package applicationModel

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoClientes
import repo.RepoViajes

@Accessors
@Observable
class PasajeAppModel {
	Cliente clienteSeleccionado
	Cliente exampleCliente = new Cliente
	List<Cliente> resultadosClientes

	Viaje viajeSeleccionado
	Micro microSeleccionado
	Pasaje pasajeSeleccionado

	def search() {
		resultadosClientes = repoClientes.allInstances
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}

	def RepoClientes getRepoClientes() {
		ApplicationContext.instance.getSingleton(typeof(Cliente))
	}

	def actualizarViajeSeleccionado(Viaje viaje) {
		repoViajes.update(viaje)
		search
	}

	def crearCliente(Cliente cliente) {
		repoClientes.create(cliente)
		search
	}

}
