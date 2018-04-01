import java.util.List

class Buscador {
	public List<Viaje> viajes

	def buscarViajePorCiudad(String ciudad) {
		viajes.filter[viajes|viajes.recorrido.contains(ciudad)]
	}
}
