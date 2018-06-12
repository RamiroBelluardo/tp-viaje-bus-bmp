package ar.edu.unq.viajebus.xtrest

import com.mashape.unirest.http.Unirest
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.json.JSONUtils

class PagosMercadoClient {
	extension JSONUtils = new JSONUtils
	
	def validarPago(DatosPago datosPago, String token) {
		val completePaymentBody = newHashMap(
			"amount" -> datosPago.amount,
			"token" -> token
		)
		
		val completePaymentResponse = crearRequest("credit-payment")
			.body(completePaymentBody.toJson)
			.asJson();
		
		if (completePaymentResponse.status !== 200) {
			throw new UserException(completePaymentResponse.body.object.toString)	
		}
	}


	def crearRequest(String uri) {
		val base = "https://pagosmercado.herokuapp.com/"
		
		Unirest
		.post(base + uri)
		.header("Content-Type", "application/json")
	} 	
}