package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Micro.Micro
import repo.RepoViajes
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoClientes

@Accessors
@Observable
class PasajeAppModel {
	Cliente clienteSeleccionado
	Viaje viajeSeleccionado
	Micro microSeleccionado

	def static search() {
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
