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
import org.joda.time.LocalDateTime
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class ViajeAppModel extends Entity implements Cloneable {

	List<Micro> resultadosMicro
	Viaje viajeSeleccionado
	Viaje example = new Viaje
	String ciudadSeleccionada
	Micro microSeleccionado



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


	val hoy = new LocalDateTime

	@Dependencies("fechaPartida", "fechaLlegada", "micro")
	def getPuedeCrearViaje() {

		viajeSeleccionado.fechaPartida !== null && viajeSeleccionado.fechaPartida.isAfter(hoy) && viajeSeleccionado.fechaLlegada !== null &&
			viajeSeleccionado.fechaLlegada.isAfter(viajeSeleccionado.fechaPartida) && viajeSeleccionado.micro !== null
	}

	@Dependencies("ciudadSeleccionada")
	def getPuedeAgregarCiudad() {
		ciudadSeleccionada !== "" && ciudadSeleccionada !== null
	}
}
