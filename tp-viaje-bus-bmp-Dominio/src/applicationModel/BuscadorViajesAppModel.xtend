package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import repo.RepoViajes
import org.uqbar.commons.applicationContext.ApplicationContext

@Accessors
@Observable
class BuscadorViajesAppModel {
	
	List<Viaje> resultadosViaje
	
	Viaje exampleViaje
	
	def void search() {
		resultadosViaje = repoViajes.search(exampleViaje.fechaPartida, exampleViaje.fechaLlegada, exampleViaje.micro)
		
	}
	
	
	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}
}