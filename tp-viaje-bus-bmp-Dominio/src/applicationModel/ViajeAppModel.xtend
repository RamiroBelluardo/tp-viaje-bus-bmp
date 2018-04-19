package applicationModel

import ar.edu.unq.viajebus.Micro.Viaje
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoPasajes
import repo.RepoViajes
import repo.RepoMicros
import ar.edu.unq.viajebus.Micro.Micro
import org.uqbar.commons.model.Entity
import ar.edu.unq.viajebus.Servicios.Servicio

@Accessors
@TransactionalAndObservable
class ViajeAppModel extends Entity implements Cloneable {
	RepoViajes repoViajes
	RepoPasajes repoPasajes
	RepoMicros repoMicros
	Viaje viajeSeleccionado
	String example
	String ciudadSeleccionada
	Micro microSeleccionado
	Servicio servicio

	new() {
		repoViajes = RepoViajes.instance
		repoPasajes = RepoPasajes.instance
		repoMicros = RepoMicros.instance
		viajeSeleccionado = new Viaje
		microSeleccionado = new Micro
	}

	def getViajes() {
		repoViajes.viajes
	}

	def getPasajes() {
		repoPasajes.pasajes
	}

	def getMicros() {
		repoMicros.micros
	}

	def agregarCiudad() {
		viajeSeleccionado.agregarCiudad(example)
	}

	def quitarCiudad() {
		viajeSeleccionado.quitarCiudad(ciudadSeleccionada)
	}
	
	def void agregarServicio(){
		viajeSeleccionado.agregarServicio(servicio)
	}

}
