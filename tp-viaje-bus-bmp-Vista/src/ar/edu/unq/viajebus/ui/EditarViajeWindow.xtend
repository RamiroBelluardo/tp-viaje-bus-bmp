package ar.edu.unq.viajebus.ui

import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoMicros
import transformer.LocalDateTimeTransformer

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.CheckBox

class EditarViajeWindow extends TransactionalDialog<Viaje> {

	new(WindowOwner parent, Viaje model) {
		super(parent, model)
		title = defaultTitle
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
			items <=> "recorrido"
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
			onClick[modelObject.agregarCiudad(modelObject.ciudadSeleccionada)]
			setAsDefault
			disableOnError
		]

		new Button(panelBotones) => [
			val elementSelected = new NotNullObservable("ciudadSeleccionada")
			caption = "Quitar"
			onClick[modelObject.quitarCiudad(modelObject.ciudadSeleccionada)]
			setAsDefault
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
			(value <=> "fechaPartida").transformer = new LocalDateTimeTransformer
			fontSize = 10
			width = 200
		]

		new Label(panelInfo) => [
			text = "Llegada"
			fontSize = 15

		]

		new TextBox(panelInfo) => [
			(value <=> "fechaLlegada").transformer = new LocalDateTimeTransformer
			fontSize = 10
			width = 200

		]

		new Label(panelInfo) => [
			text = "Micro"
			fontSize = 15
		]

		new Selector<Micro>(panelInfo) => [
			allowNull(false)
			value <=> "micro"
			val propiedadMicros = bindItems(new ObservableProperty(repoMicros, "micros"))
			propiedadMicros.adaptWith(typeof(Micro), "patente")
			// (items <=> "resultadosMicro").adapter = new PropertyAdapter(Micro, "patente")
			width = 150
		// bindEnabled(new NotNullObservable("tieneDesayuno"))
		]

		new Label(panelInfo) => [
			text = "Servicios:"
			fontSize = 15
		]

		val panelServicios = new Panel(panelInfo) => [
			layout = new ColumnLayout(2)
		]

		new CheckBox(panelServicios) => [
			value <=> "tieneDesayuno"
		]

		new Label(panelServicios) => [
			text = "Desayuno"
		]

//		new Label(panelServicios) => [
//			value <=> "tieneDesayunoAndMerienda"
//		]
		new CheckBox(panelServicios) => [
			value <=> "tieneAlmuerzo"
		]

		new Label(panelServicios) => [
			text = "Almuerzo"
		]

		new CheckBox(panelServicios) => [
			value <=> "tieneMerienda"
		]

		new Label(panelServicios) => [
			text = "Merienda"
		]

		new CheckBox(panelServicios) => [
			value <=> "tieneCena"
		]

		new Label(panelServicios) => [
			text = "Cena"
		]

		new Label(panelInfo) => [
			text = "Precio Final:"
			fontSize = 15
		]

		new Label(panelInfo) => [
			// Hacer que salga el precio con la palabra pesos o la letra p.
			value <=> "precio"
			fontSize = 10
			width = 50
		]

	// createGridActions(panelDerecho)
	}

//	def void createGridActions(Panel panel) {
//		val actionsPanel = new Panel(panel).layout = new ColumnLayout(4)
//		new Button(actionsPanel) => [
//			caption = "Aceptar"
//			onClick[|this.accept]
//			setAsDefault
//			disableOnError
//		]
//		new Button(actionsPanel) => [
//			caption = "Cancelar"
//			onClick[this.cancel]
//			disableOnError
//		]
//	}
	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|
				this.cancel
			]
		]
	}

	def getRepoMicros() {
		ApplicationContext.instance.getSingleton(Micro) as RepoMicros
	}

}
