package ar.edu.unq.viajebus.ui

import applicationModel.ViajeAppModel
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoMicros
import transformer.LocalDateTimeTransformer

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarViajeWindow extends TransactionalDialog<ViajeAppModel> {

	new(WindowOwner parent, Viaje model) {
		super(parent, createViewModel(model))
		title = defaultTitle
	}
	
	static def createViewModel(Viaje viaje) {
		val model = new ViajeAppModel()
		model.viajeSeleccionado = viaje
		return model
	}

	def defaultTitle() {
		"Editar viaje"
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelIzquierdo = new Panel(mainPanel)
		val panelDerecho = new Panel(mainPanel)

		val panelRecorrido = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(1)
		]

		new Label(panelRecorrido) => [
			text = "Recorrido"
			fontSize = 15
		]

		new List(panelRecorrido) => [
			items <=> "viajeSeleccionado.recorrido"
			value <=> "ciudadSeleccionada"
			width = 300

		]

		new TextBox(panelRecorrido) => [
			value <=> "ciudadSeleccionada"
			width = 100
			
		]

		val panelBotones = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(4)
		]

		new Button(panelBotones) => [
			caption = "Agregar"
			onClick[modelObject.viajeSeleccionado.agregarCiudad(modelObject.ciudadSeleccionada)]
			setAsDefault
			disableOnError
			bindEnabledToProperty("puedeAgregarCiudad")
		]

		new Button(panelBotones) => [
			val elementSelected = new NotNullObservable("ciudadSeleccionada")
			caption = "Quitar"
			onClick[modelObject.viajeSeleccionado.quitarCiudad(modelObject.ciudadSeleccionada)]
			disableOnError
			bindEnabled(elementSelected)
		]

		val panelInfo = new Panel(panelDerecho) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelInfo) => [
			text = "Partida"
			fontSize = 15
		]

		new TextBox(panelInfo) => [

			(value <=> "viajeSeleccionado.fechaPartida").transformer = new LocalDateTimeTransformer
			fontSize = 10
			width = 200
		]

		new Label(panelInfo) => [
			text = "Llegada"
			fontSize = 15

		]

		new TextBox(panelInfo) => [
			val fechaPartidaRequerida = new NotNullObservable("viajeSeleccionado.fechaPartida")
			(value <=> "viajeSeleccionado.fechaLlegada").transformer = new LocalDateTimeTransformer
			fontSize = 10
			width = 200
			bindEnabled(fechaPartidaRequerida)

		]

		new Label(panelInfo) => [
			text = "Micro"
			fontSize = 15
		]

		val fechaLlegadaRequerida = new NotNullObservable("viajeSeleccionado.fechaLlegada")

		new Selector<Micro>(panelInfo) => [
			allowNull(false)
			value <=> "viajeSeleccionado.micro"
			val propiedadMicros = bindItems(new ObservableProperty(repoMicros, "micros"))
			propiedadMicros.adaptWith(typeof(Micro), "patente")
			width = 150
			bindEnabled(fechaLlegadaRequerida)
		]

		new Label(panelInfo) => [
			text = "Servicios:"
			fontSize = 15
		]

		val panelServicios = new Panel(panelInfo) => [
			layout = new ColumnLayout(2)
		]

		new CheckBox(panelServicios) => [
			value <=> "viajeSeleccionado.tieneDesayuno"
			bindEnabled(fechaLlegadaRequerida)

		]

		new Label(panelServicios) => [
			text = "Desayuno ($30)"
		]

		new CheckBox(panelServicios) => [
			value <=> "viajeSeleccionado.tieneAlmuerzo"
			bindEnabled(fechaLlegadaRequerida)

		]

		new Label(panelServicios) => [
			text = "Almuerzo ($50)"
		]

		new CheckBox(panelServicios) => [
			value <=> "viajeSeleccionado.tieneMerienda"
			bindEnabled(fechaLlegadaRequerida)

		]

		new Label(panelServicios) => [
			text = "Merienda ($30)"
		]

		new CheckBox(panelServicios) => [
			value <=> "viajeSeleccionado.tieneCena"
			bindEnabled(fechaLlegadaRequerida)

		]

		new Label(panelServicios) => [
			text = "Cena ($50)"
		]

		new Label(panelServicios)

		new Label(panelInfo) => [
			text = "Precio Final:"
			fontSize = 15
		]

		new Label(panelInfo) => [
			foreground = Color.RED
			value <=> "viajeSeleccionado.precio"
			fontSize = 10
			width = 50
		]
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			val microRequerido = new NotNullObservable("micro")
			caption = "Aceptar"
			onClick [this.accept]
			disableOnError
			// bindEnabled(microRequerido)
			bindEnabledToProperty("puedeCrearViaje")
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [this.cancel]
		]
	}

	def getRepoMicros() {
		ApplicationContext.instance.getSingleton(Micro) as RepoMicros
	}

}
