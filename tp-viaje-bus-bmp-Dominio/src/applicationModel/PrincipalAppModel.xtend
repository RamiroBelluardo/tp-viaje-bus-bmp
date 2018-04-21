package applicationModel

import ar.edu.unq.viajebus.Micro.Viaje
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes
import java.util.List
import ar.edu.unq.viajebus.Micro.Pasaje
import repo.RepoPasajes

@Accessors
@Observable
class PrincipalAppModel {
	Viaje exampleViaje = new Viaje
	List<Viaje> resultadosViaje
	Viaje viajeSeleccionado

	Pasaje examplePasaje = new Pasaje
	List<Pasaje> resultadosPasaje
	Pasaje pasajeSeleccionado

	def void search() {
		// resultadosViaje = repoViajes.search(exampleViaje.fechaPartida, exampleViaje.fechaLlegada, exampleViaje.micro)
		resultadosViaje = repoViajes.search(exampleViaje.micro)
		resultadosPasaje = repoPasajes.search(examplePasaje.cliente)
	}

	def crearViaje(Viaje viaje) {
		repoViajes.create(viaje)
		search
	}

	def crearPasaje(Pasaje pasaje) {
		repoPasajes.create(pasaje)
		search
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}

	def RepoPasajes getRepoPasajes() {
		ApplicationContext.instance.getSingleton(typeof(Pasaje))
	}
	def eliminarViaje(){
		repoViajes.delete(viajeSeleccionado)
		search
	}
	

}

