import org.joda.time.LocalDateTime
import org.joda.time.Minutes
import java.util.List

class Viaje {

	public LocalDateTime fechaPartida
	public LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios
	public List<String> recorrido

	new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro, List<Servicio> servicios,
		List<String> recorrido) {
		this.fechaPartida = fechaPartida
		this.fechaLlegada = fechaLlegada
		this.micro = micro
		this.servicios = servicios
		this.recorrido = recorrido
	}

	def precio() {
		precioBase + precioServicios + precioMicro + precioFinde
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
		 * Retorna el precio adicional por el tipo de asiento.
		 */
		(precioBase + precioServicios) * micro.tipoDeAsiento.porcentaje / 100
	}

	def precioFinde() {
		/*
		 * Retorna el precio adicional si es fin de semana.
		 */
		if (esFinde(fechaPartida)) {
			(precioBase + precioServicios + precioMicro) * 10 / 100
		}
	}

	def esFinde(LocalDateTime fechaPartida) {
		/*
		 * Retorna si la fecha por parametro es fin de semana.
		 */
		val int SABADO = 6;
		val int DOMINGO = 7;

		fechaPartida.getDayOfWeek() == SABADO || fechaPartida.getDayOfWeek() == DOMINGO

	}

	def verAsientosDisponibles() {
		micro.asientosDisponibles()
	}

}
