package applicationModel

import ar.edu.unq.viajebus.Micro.Viaje
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes
import java.util.List
import ar.edu.unq.viajebus.Micro.Pasaje

@Accessors
@Observable
class PrincipalAppModel {
	Viaje example = new Viaje
	List<Viaje> resultadosViaje
	Viaje viajeSeleccionado
	
	Pasaje pasajeSeleccionado
	
	
	def crearViaje (Viaje viaje) {
		repoViajes.create(viaje)
		search
	}
	
	def void search() { 
		resultadosViaje = repoViajes.search(example.origen, example.destino, example.fechaPartida, example.fechaLlegada)
	}
	
	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}
}