import org.joda.time.LocalDateTime
import org.joda.time.Minutes
import java.util.List

class Viaje {

	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios

	new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro, List<Servicio> servicios) {
		this.fechaPartida = fechaPartida
		this.fechaLlegada = fechaLlegada
		this.micro = micro
		this.servicios = servicios;
	}

	def precio() {
		precioBase + precioServicios + precioMicro // + precioFinde
	}

	def precioBase() {
		minutos * 2
	}

	def minutos() {
		/*
		 * Retorna el tiempo que recorre el micro en minutos
		 */
		Minutes.minutesBetween(fechaPartida, fechaLlegada).minutes
	}

	def precioServicios() {
		var double res = 0

		for (Servicio s : servicios) {
			res += s.precio
		}
		res
	}

	def precioMicro() {
		/*
		 * Retorna el precio del viaje con el porcentaje del tipo de asiento agregado.
		 */
		(precioBase + precioServicios) * micro.tipoDeAsiento.porcentaje / 100
	}

}
