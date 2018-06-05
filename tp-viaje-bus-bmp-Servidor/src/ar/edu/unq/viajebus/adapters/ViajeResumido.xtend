package ar.edu.unq.viajebus.adapters

import ar.edu.unq.viajebus.Micro.Viaje
import ar.edu.unq.viajebus.Servicios.Servicio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import transformer.LocalDateTimeTransformer

@Accessors
class ViajeResumido {
	String fechaPartida
	String fechaLlegada
	List<Integer> asientosLibres
	MicroResumido micro
	List<String> recorrido
	String ciudadOrigen
	String ciudadDestino
	List<String> servicios
	double precio

	new(Viaje viaje) {
		var formateadorFecha = new LocalDateTimeTransformer
		this.fechaPartida = formateadorFecha.modelToView(viaje.fechaPartida)
		this.fechaLlegada = formateadorFecha.modelToView(viaje.fechaLlegada)
		this.asientosLibres = viaje.nrosAsientosDisponibles
		this.micro = new MicroResumido(viaje.micro)
		this.recorrido = viaje.recorrido
		this.ciudadOrigen = viaje.origen
		this.ciudadDestino = viaje.destino
		this.servicios = this.formatearServicios(viaje.servicios)
		this.precio = viaje.precio
	}

	def formatearServicios(List<Servicio> servicios) {
		var res = newArrayList
		if (servicios === null) {
			return null
		}
		for (Servicio s : servicios) {
			res.add(s.nombre)
		}
		res
	}

}
