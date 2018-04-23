package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Micro.Micro

@Accessors
@Observable
class PasajeAppModel {
	Cliente clienteSeleccionado
	Viaje viajeSeleccionado
	Micro microSeleccionado
	
	def static search() {
		
	}
	
}