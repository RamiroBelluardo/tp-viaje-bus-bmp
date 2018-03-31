import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
 class Asiento {
	int numero	
	
	Boolean disponibilidad
		new() {
		this.disponibilidad = true
		}
	
	def estaDisponible() {
		disponibilidad==true
	}
	

}