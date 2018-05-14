package ar.edu.unq.viajebus.Micro

import ar.edu.unq.viajebus.EstadoDeViaje.Aprobado
import ar.edu.unq.viajebus.EstadoDeViaje.EstadoDeViaje
import ar.edu.unq.viajebus.Servicios.Servicio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.joda.time.Minutes
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import ar.edu.unq.viajebus.EstadoDeAsiento.Disponible
import ar.edu.unq.viajebus.EstadoDeAsiento.Reservado
import ar.edu.unq.viajebus.EstadoDePasaje.Confirmado

@Accessors
@TransactionalAndObservable
class Viaje extends Entity implements Cloneable {

	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios
	List<String> recorrido
	List<Pasaje> pasajes
	EstadoDeViaje estado
	Boolean tieneDesayuno = false
	Boolean tieneAlmuerzo = false
	Boolean tieneMerienda = false
	Boolean tieneCena = false
	List<Asiento> asientos

	new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro) {
		this.fechaPartida = fechaPartida
		this.fechaLlegada = fechaLlegada
		this.micro = micro
		this.servicios = newArrayList
		this.recorrido = newArrayList
		this.pasajes = newArrayList
		this.estado = new Aprobado
		this.asientos = newArrayList
		asientos.add(new Asiento(1))
		asientos.add(new Asiento(2))
		asientos.add(new Asiento(3))
		asientos.add(new Asiento(4))
	}

	new() {
		this.recorrido = newArrayList
		this.servicios = newArrayList
		this.pasajes = newArrayList
		this.asientos = newArrayList
		this.estado = new Aprobado
		asientos.add(new Asiento(1))
		asientos.add(new Asiento(2))
		asientos.add(new Asiento(3))
		asientos.add(new Asiento(4))
	}

	@Dependencies("precioBase", "precioServicios", "precioMicro", "precioFinde", "tieneDesayuno", "tieneAlmuerzo", "tieneMerienda", "tieneCena")
	def double getPrecio() {
		if (fechaPartida === null || fechaLlegada === null) {
			return 0
		}
		precioBase + precioServicios + precioMicro + precioFinde
	}

	@Dependencies("minutos")
	def getPrecioBase() {
		minutos * 2
	}

	@Dependencies("fechaPartida", "fechaLlegada")
	def getMinutos() {
		/*
		 * Retorna el tiempo que recorre el micro en minutos
		 */
		if (fechaPartida === null || fechaLlegada === null) {
			return 0
		} else {
			Minutes.minutesBetween(fechaPartida, fechaLlegada).minutes
		}

	}

	@Dependencies("contieneDesayunoYMerienda", "contieneAlmuerzoYCena")
	def getPrecioServicios() {

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

		return res
	}

//	def getPrecioServicios() {
//		if (tieneDesayuno) {
//			return 30
//		}	
//	}
	@Dependencies("micro")
	def getPrecioMicro() {
		/*
		 * Retorna el precio adicional por el tipo de asiento.
		 */
		if (micro === null) {
			return 0
		}
		(precioBase + precioServicios) * micro.tipoDeAsiento.porcentaje / 100
	}

	def getPrecioFinde() {
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

//	def verAsientosDisponibles() {
//		micro.asientosDisponibles()
//	}
	def agregarAsiento(Asiento asiento) {
		asiento.numero = asientos.size + 1
		asientos.add(asiento)
	}

	def asientosDisponibles() {
		asientos.filter[asiento|asiento.estado instanceof Disponible].toList
	}

	def verAsientosReservados() {
		asientos.filter[asiento|asiento.estado instanceof Reservado].toList
	}

	def estaDisponibleElNro(Integer nro) {
		asientos.filter[asiento|asiento.numero == nro].get(0).estado instanceof Disponible
	}

	def buscarAsiento(Integer nro) {
		asientos.filter[asiento|asiento.numero == nro].get(0)
	}

	def reservarAsiento(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).reservar
	}

	def liberarAsiento(Integer nroAsiento) {
		asientos.filter[asiento|asiento.numero == nroAsiento].get(0).liberar
	}

	def cantidadAsientos() {
		asientos.size
	}

//	def pasajesConfirmados() {
//		pasajes.filter[pasaje|pasaje.estado instanceof Confirmado].toList
//	}
	def getNrosAsientosDisponibles() {
		val nros = newArrayList
		asientosDisponibles.forEach[Asiento a|nros.add(a.numero)]
		nros.toList
	}

//	def verAsientosReservados() {
//		micro.asientosReservados
//	}
	def agregarServicio(Servicio servicio) {
		if (servicios.filter[servicio2|servicio2.nombre == servicio.nombre].isEmpty) {
			servicios.add(servicio)
			if (servicio.nombre == "Desayuno") {
				tieneDesayuno = true
			}
			if (servicio.nombre == "Almuerzo") {
				tieneAlmuerzo = true
			}
			if (servicio.nombre == "Merienda") {
				tieneMerienda = true
			}
			if (servicio.nombre == "Cena") {
				tieneCena = true
			}

		}
	}

	def quitarServicio(Servicio servicio) {
		servicios.remove(servicio)
	}

	@Dependencies("servicios")
	def getContieneDesayunoYMerienda() {
		val String desayuno = "Desayuno"
		val String merienda = "Merienda"

		!servicios.filter[servicio|servicio.nombre == desayuno].isEmpty && !servicios.filter [ servicio |
			servicio.nombre == merienda
		].isEmpty
	}

	@Dependencies("servicios")
	def getContieneAlmuerzoYCena() {
		val String almuerzo = "Almuerzo"
		val String cena = "Cena"

		!servicios.filter[servicio|servicio.nombre == almuerzo].isEmpty && !servicios.filter [ servicio |
			servicio.nombre == cena
		].isEmpty
	}

	def agregarCiudad(String ciudad) {
		if (recorrido.filter[ciu|ciu == ciudad].isEmpty) {
			recorrido.add(ciudad)
//			origen = recorrido.head
//			destino = recorrido.last
		}
	}

	def quitarCiudad(String ciudad) {
		if (!recorrido.filter[ciu|ciu == ciudad].isEmpty) {
			recorrido.remove(ciudad)
//			origen = recorrido.head
//			destino = recorrido.last
		}
	}

	def cancelar() {
		this.estado.cancelar(this)
	}

	def eliminar() {
		this.estado.eliminar(this)
	}

	def hayPasajesVendidos() {
		!pasajes.isEmpty // TODO: Calcular con los pasajes NO cancelados
	}

	def cancelarPasajes() {
		if (pasajes.size == 1) {
			pasajes.get(0).cancelar
		} else {
			for (Pasaje p : pasajes) {
				p.cancelar
			}
		}
	}

	def int porcentajeVendido() {
		return if (asientos.size == 0)
			0
		else
			// verAsientosReservados.size * 100 / asientos.size
			pasajes.size * 100 / asientos.size // TODO: Calcular con los pasajes NO cancelados
	}

	def getPartidaCompleta() {
		val dias = fechaPartida.getDayOfMonth().toString
		val meses = fechaPartida.getMonthOfYear().toString
		val anios = fechaPartida.getYear().toString
		val res = '''«getOrigen» - «dias»/«meses»/«anios»'''
		res
	}

	def getLlegadaCompleta() {
		val dias = fechaPartida.getDayOfMonth().toString
		val meses = fechaPartida.getMonthOfYear().toString
		val anios = fechaPartida.getYear().toString
		val res = '''«getDestino» - «dias»/«meses»/«anios»'''
		res
	}

	@Dependencies("recorrido")
	def getOrigen() {
		recorrido.head
	}

	@Dependencies("recorrido")
	def getDestino() {
		recorrido.last
	}

}
