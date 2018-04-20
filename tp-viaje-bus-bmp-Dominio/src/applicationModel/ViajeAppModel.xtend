package applicationModel

import ar.edu.unq.viajebus.Buscador.Buscador
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Servicios.Desayuno
import ar.edu.unq.viajebus.Servicios.Servicio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoMicros
import repo.RepoPasajes
import repo.RepoViajes

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
	Buscador buscador
	List<Viaje> resultados
	String fechaPartidaSeleccionada
	String fechaLlegadaSeleccionada

	new() {
		repoViajes = RepoViajes.instance
		repoPasajes = RepoPasajes.instance
		repoMicros = RepoMicros.instance
		viajeSeleccionado = new Viaje
		microSeleccionado = new Micro
		buscador = new Buscador
	}
	
	def setTieneDesayuno(Boolean tiene){
		tiene
	}

	def getTieneDesayuno(){
		viajeSeleccionado.tieneServicio(Desayuno)
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

	def agregarServicio() {
		viajeSeleccionado.agregarServicio(servicio)
	}

	def search() {
		// resultados = viajes.filter[viajes|viajes.recorrido.contains(ciudadSeleccionada)].toList
		resultados = viajes.filter [ viajes |
			this.match(ciudadSeleccionada, viajes.recorrido) &&
				this.match(fechaPartidaSeleccionada, viajes.fechaPartida) &&
				this.match(fechaLlegadaSeleccionada, viajes.fechaLlegada)
		].toList
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue == null) {
			return true
		}
		if (realValue == null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}

}
