package applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repo.RepoViajes
import repo.RepoPasajes

@Accessors
@Observable
class PrincipalAppModel {
	RepoViajes repoViajes
	RepoPasajes repoPasajes	
	
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