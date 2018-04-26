package applicationModel

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes

@Accessors
@Observable
class BuscadorViajesAppModel {

	List<Viaje> resultadosViaje
	String ciudadSeleccionada
	LocalDate fechaPartidaSeleccionada
	LocalDate fechaLlegadaSeleccionada
	Viaje exampleViaje = new Viaje
	Viaje viajeSeleccionado
	Pasaje pasajeSeleccionado
	Micro microSeleccionado

	def search() {
		resultadosViaje = repoViajes.search(ciudadSeleccionada, fechaPartidaSeleccionada, fechaLlegadaSeleccionada)
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}
	
	def actualizarDatos() {
		pasajeSeleccionado.viaje = viajeSeleccionado
		microSeleccionado= viajeSeleccionado.micro
	}
	
}
