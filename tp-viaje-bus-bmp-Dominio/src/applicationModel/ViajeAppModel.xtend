package applicationModel

import ar.edu.unq.viajebus.Buscador.Buscador
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Servicios.Servicio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repo.RepoMicros

@Accessors
@TransactionalAndObservable
class ViajeAppModel extends Entity implements Cloneable {
	
	List<Micro> resultadosMicro

	Viaje viajeSeleccionado
	String example
	String ciudadSeleccionada
	Micro microSeleccionado
	Servicio servicio
	Buscador buscador
	List<Viaje> resultados
	String fechaPartidaSeleccionada
	String fechaLlegadaSeleccionada
	Boolean tieneDesayuno = false
//	Boolean tieneAlmuerzo = false
//	Boolean tieneMerienda = false
//	Boolean tieneCena = false

	new() {
//		repoViajes = RepoViajes.instance
//		repoPasajes = RepoPasajes.instance
//		repoMicros = RepoMicros.instance
//		viajeSeleccionado = new Viaje
//		microSeleccionado = new Micro
//		buscador = new Buscador
	}
	
	
	def void search() { 
		resultadosMicro = repoMicros.search
	}
	
	def RepoMicros getRepoMicros() {
		ApplicationContext.instance.getSingleton(typeof(Micro))
	}
	
	
	
	
	
	
	
	
	@Dependencies("tieneDesayuno")
    def tieneServicioDesayuno() {
        tieneDesayuno
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


}
