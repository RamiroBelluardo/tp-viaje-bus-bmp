package ar.edu.unq.viajebus.ui

import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.arena.windows.WindowOwner

class CrearViajeWindow extends EditarViajeWindow {

	new(WindowOwner parent, Viaje model) {
		super(parent, model)
	}

	override defaultTitle() {
		"Crear viaje"
	}

}
