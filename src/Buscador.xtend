import java.util.List
import org.joda.time.LocalDateTime

class Buscador {
	public List<Viaje> viajes

	def buscarViajePorCiudad(String ciudad) {
		viajes.filter[viajes|viajes.recorrido.contains(ciudad)]
	}

	def buscarViajePorFechaPartida(LocalDateTime fecha) {
		viajes.filter[viajes|viajes.fechaPartida.equals(fecha)]
	}

	def buscarViajePorFechaLlegada(LocalDateTime fecha) {
		viajes.filter[viajes|viajes.fechaLlegada.equals(fecha)]
	}
}
