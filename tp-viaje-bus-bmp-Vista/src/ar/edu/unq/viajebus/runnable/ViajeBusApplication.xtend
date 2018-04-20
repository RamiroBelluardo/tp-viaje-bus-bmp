package ar.edu.unq.viajebus.runnable

import ar.edu.unq.viajebus.ui.PantallaPrincipalWindow
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class ViajeBusApplication extends Application {
	
	new(ViajeBusBootstrap bootstrap) {
		super(bootstrap)
	}

	static def void main(String[] args) {
		new ViajeBusApplication(new ViajeBusBootstrap).start
	}

	override protected Window <?> createMainWindow() {
		new PantallaPrincipalWindow(this)
	}

}
