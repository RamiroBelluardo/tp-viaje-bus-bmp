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

@Accessors
@TransactionalAndObservable
class Viaje extends Entity implements Cloneable{

	LocalDateTime fechaPartida
	LocalDateTime fechaLlegada
	Micro micro
	List<Servicio> servicios
	List<String> recorrido
	List<Pasaje> pasajes
	EstadoDeViaje estado
	String origen
	String destino
	String ciudadSeleccionada
	Boolean tieneDesayuno = false
	Boolean tieneAlmuerzo = false
	Boolean tieneMerienda = false
	Boolean tieneCena     = false

	new(LocalDateTime fechaPartida, LocalDateTime fechaLlegada, Micro micro) {
		this.fechaPartida = fechaPartida
		this.fechaLlegada = fechaLlegada
		this.micro = micro
		this.servicios = newArrayList
		this.recorrido = newArrayList
		this.pasajes = newArrayList
		this.estado = new Aprobado
		this.origen = ""
		this.destino = ""
	}
	
	new() {
		this.recorrido = newArrayList
		this.servicios = newArrayList
	}

	@Dependencies("precioBase", "precioServicios", "precioMicro")
	def double getPrecio() {
		
		precioBase + precioServicios //+ precioMicro// + precioFinde
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
		 if(fechaPartida === null || fechaLlegada === null){
		 	return 0
		 }
		 else{
			Minutes.minutesBetween(fechaPartida, fechaLlegada).minutes	 	
		 }
	}

//	@Dependencies("servicios")
//	def getPrecioServicios() {
//		var double res = 0
//
//		for (Servicio s : servicios) {
//			res += s.precio
//		}
//		 
//		  		if (contieneDesayunoYMerienda) {
//		  			res -= 30
//		  		}
//
//		 		if (contieneAlmuerzoYCena) {
//		  			res -= 50
//		  		}
//		 
//		res
//	val String desayuno = "Desayuno"
//	if (!servicios.filter[servicio|servicio.nombre == desayuno].isEmpty) {
//		50
//	}
//	else {
//		0
//	}
//		
//	}

	@Dependencies("tieneDesayuno", "tieneMerienda", "tieneAlmuerzo", "tieneCena")
	def  getPrecioServicios() {
		if(tieneDesayuno) {
			return 30
		}
	}

	
//	def getPrecioMicro() {
//		/*
//		 * Retorna el precio adicional por el tipo de asiento.
//		 */
//		(precioBase + precioServicios) * 2//micro.tipoDeAsiento.porcentaje / 100
//	}
//
//	def precioFinde() {
//		/*
//		 * Retorna el precio adicional si es fin de semana.
//		 */
//		if (esFinde) {
//			(precioBase + precioServicios + precioMicro) * 10 / 100
//		}
//	}

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
	
	def quitarCiudad(String ciudad) {
		if(!recorrido.filter[ciu | ciu == ciudad].isEmpty) {
			recorrido.remove(ciudad)
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
	
	def getOrigen(){
		this.recorrido.head
	}
	
	def getDestino(){
		this.recorrido.last
	}
	
			
}
