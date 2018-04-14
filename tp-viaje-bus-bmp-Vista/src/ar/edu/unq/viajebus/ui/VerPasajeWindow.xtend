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

class VerPasajeWindow extends TransactionalDialog<PasajeAppModel> {

	new(WindowOwner parent) {
		super(parent, new PasajeAppModel)
		title = "Viaje Bus"
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelClientes = new Panel(mainPanel)
		panelClientes.layout = new ColumnLayout(2)

		new Label(panelClientes) => [
			text = "Cliente"
		]

		new Button(panelClientes) => [
			caption = "Nuevo"
		]

		new Selector(panelClientes) => [
			allowNull = false
		]

		val panelViajes = new Panel(mainPanel)
		panelViajes.layout = new ColumnLayout(2)

		new Label(panelViajes) => [
			text = "Viaje"
		]

		new Button(panelViajes) => [
			caption = "Buscar"
		]

		new TextBox(panelViajes) => []

		val panelPrecios = new Panel(mainPanel)
		panelPrecios.layout = new ColumnLayout(2)

		new Label(panelPrecios) => [
			text = "Precio"
		]

		new TextBox(panelPrecios) => []

		new Label(mainPanel) => [
			text = "Asiento:"
		]

		val panelAsientos = new Panel(mainPanel)
		panelAsientos.layout = new ColumnLayout(8)

		crearAsientos(panelAsientos, 24)

	}

	def crearAsientos(Panel panel, int nroAsientos) {
		for (var i = 1; i <= nroAsientos; i++) {
			new Label(panel).text = i.toString
			new CheckBox(panel) => []
		}
	}

}
