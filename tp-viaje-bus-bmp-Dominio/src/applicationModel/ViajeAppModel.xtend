package applicationModel

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoMicros
import repo.RepoViajes

@Accessors
@TransactionalAndObservable
class ViajeAppModel extends Entity implements Cloneable {

	List<Micro> resultadosMicro
	Viaje viajeSeleccionado
	Viaje example = new Viaje
	String ciudadSeleccionada
	Micro microSeleccionado

//	Boolean tieneDesayuno = false
//	Boolean tieneAlmuerzo = false
//	Boolean tieneMerienda = false
//	Boolean tieneCena = false
//	def void search() {
//		resultadosMicro = repoMicros.getMicros
//	}

	def RepoMicros getRepoMicros() {
		ApplicationContext.instance.getSingleton(typeof(Micro))
	}

	def RepoViajes getRepoViajes() {
		ApplicationContext.instance.getSingleton(typeof(Viaje))
	}

//	@Dependencies("tieneDesayuno")
//	def getTieneServicioDesayuno() {
//		tieneDesayuno
//	}
	def agregarCiudad() {
		example.agregarCiudad(ciudadSeleccionada)
	}

	def quitarCiudad() {
		example.quitarCiudad(ciudadSeleccionada)
	}

//	@Dependencies("tieneDesayuno")
//	def setTieneDesayuno() {
//		example.agregarServicio(new Desayuno)
//	}
}
