import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Micro {

	String patente
	List<Asiento> asientos
	TipoAsiento tipoDeAsiento
	Boolean tieneTele

	new(String patente, TipoAsiento tipoAsiento, Boolean tieneTele) {
		this.patente = patente
		this.asientos = newArrayList
		this.tipoDeAsiento = tipoAsiento
		this.tieneTele = tieneTele
	}

	def agregarAsiento(Asiento asiento) {
		asiento.numero = asientos.size + 1
		asientos.add(asiento)
	}

	def asientosDisponibles() {
		asientos.filter[asiento|asiento.estaDisponible]

	}

}
