package ar.edu.unq.viajebus.ui

import applicationModel.ViajeAppModel
import org.uqbar.arena.windows.WindowOwner

class CrearViajeWindow extends EditarViajeWindow {

	new(WindowOwner parent, ViajeAppModel model) {
		super(parent, model)
		modelObject.search
	}

	override defaultTitle() {
		"Crear viaje"
	}

}
