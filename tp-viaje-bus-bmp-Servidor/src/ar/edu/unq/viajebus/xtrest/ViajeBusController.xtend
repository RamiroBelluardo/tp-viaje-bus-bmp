package ar.edu.unq.viajebus.xtrest

import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller

@Controller
class ViajeBusController {
	
	def static void main(String[] args) {
		XTRest.start(9200, ViajeBusController)
	}
}