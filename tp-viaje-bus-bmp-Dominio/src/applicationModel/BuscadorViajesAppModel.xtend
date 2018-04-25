package applicationModel

import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes
import ar.edu.unq.viajebus.Micro.Pasaje

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

	def search() {
		resultadosViaje = repoViajes.search(ciudadSeleccionada, fechaPartidaSeleccionada, fechaLlegadaSeleccionada)
	}

	def setViaje() {
		pasajeSeleccionado.viaje = viajeSeleccionado
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}
}
