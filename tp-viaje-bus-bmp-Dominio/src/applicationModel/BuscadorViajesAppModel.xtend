package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import repo.RepoViajes
import org.uqbar.commons.applicationContext.ApplicationContext
import org.joda.time.LocalDateTime

@Accessors
@Observable
class BuscadorViajesAppModel {

	List<Viaje> resultadosViaje
	String ciudadSeleccionada
	LocalDateTime fechaPartidaSeleccionada
	LocalDateTime fechaLlegadaSeleccionada
	Viaje exampleViaje
	

	def void search() {
		if (fechaPartidaSeleccionada == null && fechaLlegadaSeleccionada == null) {
			resultadosViaje = repoViajes.search(ciudadSeleccionada)
		} else {
			if (fechaLlegadaSeleccionada == null) {
				resultadosViaje = repoViajes.search(ciudadSeleccionada, fechaPartidaSeleccionada)
			} else {
				repoViajes.search(ciudadSeleccionada, fechaPartidaSeleccionada, fechaLlegadaSeleccionada)
			}
		}
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}
}
