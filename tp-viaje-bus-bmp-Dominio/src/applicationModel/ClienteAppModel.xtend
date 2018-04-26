package applicationModel

import ar.edu.unq.viajebus.Cliente.Cliente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoClientes
import org.uqbar.commons.applicationContext.ApplicationContext

@Accessors
@TransactionalAndObservable
class ClienteAppModel extends Entity implements Cloneable {

	Cliente clienteSeleccionado

	def RepoClientes getRepoClientes() {
		ApplicationContext.instance.getSingleton(typeof(Cliente))
	}

}
