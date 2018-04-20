package applicationModel

import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.eclipse.xtend.lib.annotations.Accessors
import repo.RepoClientes
import ar.edu.unq.viajebus.Cliente.Cliente

@Accessors
@TransactionalAndObservable
class ClienteAppModel {

	RepoClientes repoClientes
	Cliente clienteSeleccionado = new Cliente

//	new() {
//		repoClientes = RepoClientes.instance
//	}
//
//	def getClientes() {
//		repoClientes.clientes
//	}
}
