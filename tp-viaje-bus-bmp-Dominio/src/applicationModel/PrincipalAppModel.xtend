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
		resultadosViaje = repoViajes.search(exampleViaje.fechaPartida, exampleViaje.fechaLlegada, exampleViaje.micro)
		// resultadosViaje = repoViajes.search(exampleViaje.precio, exampleViaje.micro)
		resultadosPasaje = repoPasajes.search(examplePasaje.cliente)
	}

	def crearViaje(Viaje viaje) {
		repoViajes.create(viaje)
		this.actualizarServicios(viaje)
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
		this.actualizarServicios(viajeSeleccionado)
		search
	}

	def actualizarServicios(Viaje viaje) {
		// viajeSeleccionado.servicios.forEach[Servicio s | s.actualizar]
		actualizarDesayuno(viaje)
		actualizarAlmuerzo(viaje)
		actualizarMerienda(viaje)
		actualizarCena(viaje)
	}

	def actualizarDesayuno(Viaje viaje) {
		if (viaje.tieneDesayuno) {
			viaje.agregarServicio(new Desayuno)
		} else {
			var servicio = viaje.servicios.filter[servicio|servicio.nombre == "Desayuno"]
			if (!servicio.empty) {
				viaje.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarAlmuerzo(Viaje viaje) {
		if (viaje.tieneAlmuerzo) {
			viaje.agregarServicio(new Almuerzo)
		} else {
			var servicio = viaje.servicios.filter[servicio|servicio.nombre == "Almuerzo"]
			if (!servicio.empty) {
				viaje.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarMerienda(Viaje viaje) {
		if (viaje.tieneMerienda) {
			viaje.agregarServicio(new Merienda)
		} else {
			var servicio = viaje.servicios.filter[servicio|servicio.nombre == "Merienda"]
			if (!servicio.empty) {
				viaje.quitarServicio(servicio.toList.get(0))
			}

		}
	}

	def actualizarCena(Viaje viaje) {
		if (viaje.tieneCena) {
			viaje.agregarServicio(new Cena)
		} else {
			var servicio = viaje.servicios.filter[servicio|servicio.nombre == "Cena"]
			if (!servicio.empty) {
				viaje.quitarServicio(servicio.toList.get(0))
			}

		}
	}
}
