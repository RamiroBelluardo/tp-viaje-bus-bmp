package ar.edu.unq.viajebus.Mailing

import java.util.Properties
import javax.mail.Authenticator
import javax.mail.Message
import javax.mail.MessagingException
import javax.mail.PasswordAuthentication
import javax.mail.Session
import javax.mail.Transport
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeMessage
import ar.edu.unq.viajebus.Micro.Pasaje

class GMailSender {

	UserPasswordAuthentication authentication
	
	String pattern = "dd/MM/yyyy HH:mm";

	new(String username, String password) {
		authentication = new UserPasswordAuthentication(username, password)
	}

	def sendMail(String to, String subject, String text) {

		try {
			val message = new MimeMessage(createSession)
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to))
			message.subject = subject
			message.text = text
			Transport.send(message)

		} catch (MessagingException e) {
			e.printStackTrace
			throw e
		}
	}

	private def createSession() {
		val props = new Properties => [
			put("mail.smtp.auth", "true")
			put("mail.smtp.starttls.enable", "true")
			put("mail.smtp.host", "smtp.gmail.com")
			put("mail.smtp.port", "587")
		]

		Session.getInstance(props, authentication)
	}

	public static GMailSender instance

	static def instancia() { instance }

	static def config(GMailSender sender) {
		instance = sender
	}

	def notificarCompraDePasaje(Pasaje pasaje) {
		this.sendMail(pasaje.cliente.mail, "ViajeBus: Compra realizada con éxito",
			"Estimado/a " + pasaje.cliente.nombre +
				", su compra de pasaje con destino " +pasaje.viaje.destino + " se realizó exitosamente.\n\n" + 
				"Datos del pasaje: \n\n" +
				"- Ciudad de partida: " + pasaje.viaje.origen + "\n" +
				"- Ciudad de llegada: " + pasaje.viaje.destino + "\n" +
				"- Fecha de partida: " + pasaje.viaje.fechaPartida.toString(pattern) + "hs" + "\n" +
				"- Fecha de llegada: " + pasaje.viaje.fechaLlegada.toString(pattern) + "hs" + "\n" +
				 "- Número de asiento: " + pasaje.asiento.numero + "\n\n" +
				"Muchas gracias por elegirnos!\n\n ViajeBus")
	}

	def notificarCancelacionDePasaje(Pasaje pasaje) {
		this.sendMail(pasaje.cliente.mail, "ViajeBus: Pasaje cancelado",
			"Estimado/a " + pasaje.cliente.nombre +
				", lamentamos informarle que su pasaje con destino " +pasaje.viaje.destino + " ha sido cancelado. \n\n" + 
				 "Datos del pasaje: \n\n" +
				"- Ciudad de partida: " + pasaje.viaje.origen + "\n" +
				"- Ciudad de llegada: " + pasaje.viaje.destino + "\n" +
				"- Fecha de partida: " + pasaje.viaje.fechaPartida.toString(pattern) + "hs" + "\n" +
				"- Fecha de llegada: " + pasaje.viaje.fechaLlegada.toString(pattern) + "hs" + "\n" +
				 "- Número de asiento: " + pasaje.asiento.numero + "\n\n" +
				"Disculpe las molestias y muchas gracias por elegirnos!\n\n ViajeBus")
	}

}

class UserPasswordAuthentication extends Authenticator {

	val String username
	val String password

	new(String _username, String _password) {
		username = _username
		password = _password
	}

	override protected getPasswordAuthentication() { new PasswordAuthentication(username, password) }

}
  