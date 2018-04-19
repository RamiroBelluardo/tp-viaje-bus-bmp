package ar.edu.unq.viajebus.ui

import applicationModel.ViajeAppModel
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import repo.RepoViajes
import transformer.LocalDateTimeTransformer

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.viajebus.Servicios.Desayuno

class EditarViajeWindow extends TransactionalDialog<ViajeAppModel> {

	new(WindowOwner parent) {
		super(parent, new ViajeAppModel)
		title = "Viaje Bus"
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
			value <=> "example"
			width = 100
		]

		val panelBotones = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(4)
		]
		new Button(panelBotones) => [
			caption = "Agregar"
			onClick[modelObject.agregarCiudad]
			setAsDefault
			disableOnError
		]
		new Button(panelBotones) => [
			val elementSelected = new NotNullObservable("ciudadSeleccionada")
			caption = "Quitar"
			onClick[modelObject.quitarCiudad]
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
			(value <=> "viajeSeleccionado.fechaPartida").transformer = new LocalDateTimeTransformer

			fontSize = 10
			width = 200
		]

		new Label(panelInfo) => [
			text = "Llegada"
			fontSize = 15

		]

		new TextBox(panelInfo) => [
			(value <=> "viajeSeleccionado.fechaLlegada").transformer = new LocalDateTimeTransformer
			fontSize = 10
			width = 200

		]
		new Label(panelInfo) => [
			text = "Micro"
			fontSize = 15
		]

		new Selector<Micro>(panelInfo) => [
			(items <=> "micros").adapter = new PropertyAdapter(Micro, "patente")
			value <=> "microSeleccionado"
			width = 150
		]
		new Label(panelInfo) => [
			text = "Servicios:"
			fontSize = 15
		]

		val panelServicios = new Panel(panelInfo) => [
			layout = new ColumnLayout(2)
		]
		new CheckBox(panelServicios) => [
			//enabled <=> []
			//value <=> [modelObject.agregarServicio()]
		]
		new Label(panelServicios) => [
			text = "Desayuno"
		]
		new CheckBox(panelServicios) => []
		new Label(panelServicios) => [
			text = "Almuerzo"
		]
		new CheckBox(panelServicios) => []
		new Label(panelServicios) => [
			text = "Merienda"
		]
		new CheckBox(panelServicios) => []
		new Label(panelServicios) => [
			text = "Cena"
		]
		new Label(panelInfo) => [
			text = "Precio Final:"
			fontSize = 15
		]
		new Label(panelInfo) => [
			fontSize = 10
			width = 50
		]
		createGridActions(panelDerecho)
	}

	def void createGridActions(Panel panel) {

		val actionsPanel = new Panel(panel).layout = new ColumnLayout(4)

		new Button(actionsPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
			disableOnError
		]

	}

 
  	def getRepoViajes() {
  		RepoViajes.instance
  	}

  	override executeTask() {

  		repoViajes.create(modelObject.viajeSeleccionado)

  		super.executeTask()
  	}
 
}
