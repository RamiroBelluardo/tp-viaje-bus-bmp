package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes
import repo.RepoPasajes
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje

@Accessors
@Observable
class PrincipalAppModel {
	RepoViajes repoViajes
	RepoPasajes repoPasajes	
	Viaje viajeSeleccionado
	Pasaje pasajeSeleccionado
	
	new(){
		repoViajes = RepoViajes.instance
		repoPasajes = RepoPasajes.instance
	}
	
	def getViajes() {
		repoViajes.viajes
	}
	
	def getPasajes() {
		repoPasajes.pasajes
	}
}