package ar.edu.unq.viajebus.Micro

import org.joda.time.LocalDateTime
import org.joda.time.Minutes
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.viajebus.Servicios.Servicio
import org.uqbar.commons.model.exceptions.UserException
import EstadoDeViaje.EstadoDeViaje
import EstadoDeViaje.Eliminado
import EstadoDeViaje.Aprobado
import EstadoDeViaje.ViajeCancelado

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
		//Cuando salga del for deberiamos preguntar si tiene desayuno y merienda o cena y almuerzo y restar lo que corresponda
		res
	}

	/*def precioServicios() {
	 * 	//var double res = 0

	 * 	for (Servicio s : servicios) {
	 * 		res += s.precio
	 * 	}
	 * 	res
	 }*/
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

//	def nrosDeAsientosDisponibles() {
//		var List<Integer> nrosDisponibles = newArrayList
//
//		for (Asiento a : micro.asientosDisponibles) {
//			nrosDisponibles.add(a.numero)
//		}
//		nrosDisponibles
//	}
	def agregarServicio(Servicio servicio) {
		if (!servicios.contains(servicio)) {
			this.servicios.add(servicio)
		}

	}

	def agregarCiudad(String ciudad) {
		recorrido.add(ciudad)
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
