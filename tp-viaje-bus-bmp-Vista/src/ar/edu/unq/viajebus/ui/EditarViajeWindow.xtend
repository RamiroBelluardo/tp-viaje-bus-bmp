package ar.edu.unq.viajebus.ui

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import applicationModel.ViajeAppModel
import org.uqbar.arena.widgets.List
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import ar.edu.unq.viajebus.Servicios.Desayuno

class EditarViajeWindow extends TransactionalDialog<ViajeAppModel> {

	new(WindowOwner parent) {
		super(parent, new ViajeAppModel)
		title = "Viaje Bus"
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
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
			// items <=> "recorrido"
			// value <=> "recorridoSeleccionado"
			width = 300

		]

		new TextBox(panelRecorrido) => [
			width = 100
		]

		val panelBotones = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(4)
		]
		new Button(panelBotones) => [
			caption = "Agregar"
			// onClick[]
			setAsDefault
			disableOnError
		]
		new Button(panelBotones) => [
			caption = "Quitar"
			// onClick[]
			setAsDefault
			disableOnError
		]

		val panelInfo = new Panel(panelDerecho) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelInfo) => [
			text = "Partida"
			fontSize = 15
		]

		new TextBox(panelInfo) => [
			fontSize = 10
			width = 200
		]
		new Label(panelInfo) => [
			text = "Llegada"
			fontSize = 15

		]

		new TextBox(panelInfo) => [
			fontSize = 10
			width = 200

		]
		new Label(panelInfo) => [
			text = "Micro"
			fontSize = 15
		]

		new Selector(panelInfo) => [
			width = 150
		]
		new Label(panelInfo) => [
			text = "Servicios:"
			fontSize = 15
		]

		val panelServicios = new Panel(panelInfo) => [
			layout = new ColumnLayout(4)
		]
		new CheckBox(panelServicios) => []
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
		new TextBox(panelInfo) => [
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
			setAsDefault
			disableOnError
		]

	}

}
