package ar.edu.unq.viajebus.runnable

import org.uqbar.arena.Application
import ar.edu.unq.viajebus.ui.BuscarViajesWindow
import ar.edu.unq.viajebus.ui.PantallaPrincipalWindow
import ar.edu.unq.viajebus.ui.NuevoClienteWindow
import ar.edu.unq.viajebus.Cliente.Cliente

class ViajeBusApplication extends Application {

	static def void main(String[] args) {
		new ViajeBusApplication().start
	}

	override protected createMainWindow() {
		new BuscarViajesWindow(this)
	}

}