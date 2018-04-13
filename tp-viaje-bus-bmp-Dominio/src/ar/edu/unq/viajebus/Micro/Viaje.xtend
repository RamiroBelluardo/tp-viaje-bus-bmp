package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.EstadoDeViaje.Aprobado
import ar.edu.unq.viajebus.EstadoDeViaje.EstadoDeViaje
import ar.edu.unq.viajebus.Servicios.Servicio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.joda.time.Minutes

@Accessors
class Viaje {

	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios
	List<String> recorrido
	List<Pasaje> pasajes
	EstadoDeViaje estado

	new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro) {
		this.fechaPartida = fechaPartida
		this.fechaLlegada = fechaLlegada
		this.micro = micro
		this.servicios = newArrayList
		this.recorrido = newArrayList
		this.pasajes = newArrayList
		this.estado = new Aprobado
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
		 
		  		if (contieneDesayunoYMerienda) {
		  			res -= 30
		  		}

		 		if (contieneAlmuerzoYCena) {
		  			res -= 50
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
		if (esFinde) {
			(precioBase + precioServicios + precioMicro) * 10 / 100
		}
	}

	def esFinde() {
		/*
		 * Retorna si la fecha de partida del viaje es fin de semana.
		 */
		val int SABADO = 6;
		val int DOMINGO = 7;

		fechaPartida.getDayOfWeek() == SABADO || fechaPartida.getDayOfWeek() == DOMINGO

	}

	def verAsientosDisponibles() {
		micro.asientosDisponibles()
	}

	def verAsientosReservados() {
		micro.asientosReservados
	}

	def agregarServicio(Servicio servicio) {
		if (servicios.filter[servicio2|servicio2.nombre == servicio.nombre].isEmpty) {
			servicios.add(servicio)
		}
	}

	def contieneDesayunoYMerienda() {
		val String desayuno = "Desayuno"
		val String merienda = "Merienda"

		!servicios.filter[servicio|servicio.nombre == desayuno].isEmpty  &&
		!servicios.filter[servicio|servicio.nombre == merienda].isEmpty
	}

	def contieneAlmuerzoYCena() {
		val String almuerzo = "Almuerzo"
		val String cena = "Cena"

		!servicios.filter[servicio|servicio.nombre == almuerzo].isEmpty  &&
		!servicios.filter[servicio|servicio.nombre == cena].isEmpty  
	}

	def agregarCiudad(String ciudad) {
		if (recorrido.filter[ciu|ciu == ciudad].isEmpty) {
			recorrido.add(ciudad)
		}
	}

	def cancelar() {
		this.estado.cancelar(this)
	}

	def eliminar() {
		this.estado.eliminar(this)
	}

	def hayPasajesVendidos() {
		!pasajes.isEmpty
	}

}
