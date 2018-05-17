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
	List<Servicio> servicios
	double precio

	new(Viaje viaje) {
		var formateador = new LocalDateTimeTransformer
		this.fechaPartida = formateador.modelToView(viaje.fechaPartida)
		this.fechaLlegada = formateador.modelToView(viaje.fechaLlegada)
		this.asientosLibres = viaje.nrosAsientosDisponibles
		this.micro = new MicroResumido(viaje.micro)
		this.recorrido = viaje.recorrido
		this.servicios = viaje.servicios
		this.precio = viaje.precio
	}

}
