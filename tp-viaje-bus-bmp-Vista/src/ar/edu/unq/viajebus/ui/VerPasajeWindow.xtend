package ar.edu.unq.viajebus.ui

import applicationModel.PasajeAppModel
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
import org.uqbar.arena.windows.Dialog

class VerPasajeWindow extends TransactionalDialog<PasajeAppModel> {

	new(WindowOwner parent) {
		super(parent, new PasajeAppModel)
		title = "Viaje Bus"
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		val panelIzquierdo = new Panel(mainPanel)
		val panelDerecho = new Panel(mainPanel)

		val panelCliente = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelCliente) => [
			text = "Cliente"
			fontSize = 15
		]

		new Button(panelCliente) => [
			caption = "Nuevo"
			width = 100
			onClick[nuevoCliente]
		]

		new Selector(panelIzquierdo) => [
			allowNull = false
		]

		val panelViaje = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelViaje) => [
			text = "Viaje"
			fontSize = 15
		]

		new Button(panelViaje) => [
			caption = "Buscar"
			onClick[buscarViaje]
			width = 100
		]

		new TextBox(panelViaje) => [
			width = 100
		]

		val panelPrecios = new Panel(panelIzquierdo) => [
			layout = new ColumnLayout(2)
		]
		new Label(panelPrecios) => [
			text = "Precio"
			fontSize = 15
		]

		new Label(panelPrecios) => []

		val panelAsiento = new Panel(panelDerecho) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelAsiento) => [
			text = "Asiento:"
			fontSize = 15
		]

		new Label(panelAsiento) => [
			text = "12"
			fontSize = 15
		]

		val panelAsientos = new Panel(panelDerecho)
		panelAsientos.layout = new ColumnLayout(8)
		crearAsientos(panelAsientos, 24)

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
		]
	}

	def crearAsientos(Panel panel, int nroAsientos) {
		for (var i = 1; i <= nroAsientos; i++) {
			new Label(panel).text = i.toString
			new CheckBox(panel) => []
		}
	}

	def nuevoCliente() {
		PantallaPrincipalWindow.openDialog(new NuevoClienteWindow(this))
	}
	
	def buscarViaje(){
		openDialog(new BuscarViajesWindow(this))
	}
	def static openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
