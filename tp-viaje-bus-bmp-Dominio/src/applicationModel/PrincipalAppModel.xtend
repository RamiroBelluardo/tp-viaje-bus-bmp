package applicationModel

import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Servicios.Almuerzo
import ar.edu.unq.viajebus.Servicios.Cena
import ar.edu.unq.viajebus.Servicios.Desayuno
import ar.edu.unq.viajebus.Servicios.Merienda
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import repo.RepoPasajes
import repo.RepoViajes
import ar.edu.unq.viajebus.TipoAsiento.Cama

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

	def eliminarViaje() {
		repoViajes.delete(viajeSeleccionado)
		search
		viajeSeleccionado = null
	}

	def actualizarViajeSeleccionado() {
		repoViajes.update(viajeSeleccionado)
		this.actualizarServicios
		search
	}

	def actualizarServicios() {
		// viajeSeleccionado.servicios.forEach[Servicio s | s.actualizar]
		actualizarDesayuno
		actualizarAlmuerzo
		actualizarMerienda
		actualizarCena
	}

	def actualizarDesayuno() {
		if (viajeSeleccionado.tieneDesayuno) {
			viajeSeleccionado.agregarServicio(new Desayuno)
		} else {
			var servicio = viajeSeleccionado.servicios.filter[servicio|servicio.nombre == "Desayuno"]
			if (!servicio.empty) {
				viajeSeleccionado.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarAlmuerzo() {
		if (viajeSeleccionado.tieneAlmuerzo) {
			viajeSeleccionado.agregarServicio(new Almuerzo)
		} else {
			var servicio = viajeSeleccionado.servicios.filter[servicio|servicio.nombre == "Almuerzo"]
			if (!servicio.empty) {
				viajeSeleccionado.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarMerienda() {
		if (viajeSeleccionado.tieneMerienda) {
			viajeSeleccionado.agregarServicio(new Merienda)
		} else {
			var servicio = viajeSeleccionado.servicios.filter[servicio|servicio.nombre == "Merienda"]
			if (!servicio.empty) {
				viajeSeleccionado.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarCena() {
		if (viajeSeleccionado.tieneCena) {
			viajeSeleccionado.agregarServicio(new Cena)
		} else {
			var servicio = viajeSeleccionado.servicios.filter[servicio|servicio.nombre == "Cena"]
			if (!servicio.empty) {
				viajeSeleccionado.quitarServicio(servicio.toList.get(0))
			}

		}
	}

//	def actualizarMicro() {
//		if (viajeSeleccionado.micro.tipoDeAsiento instanceof Cama) {
//			
//		}
//	}

}
