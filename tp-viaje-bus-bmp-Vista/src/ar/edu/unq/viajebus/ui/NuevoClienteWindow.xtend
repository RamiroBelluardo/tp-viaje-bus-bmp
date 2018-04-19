package ar.edu.unq.viajebus.ui

import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import applicationModel.ClienteAppModel

class NuevoClienteWindow extends TransactionalDialog<ClienteAppModel> {

	new(WindowOwner parent) {
		super(parent, new ClienteAppModel)
		title = "Viaje Bus"
	}

	override protected createFormPanel(Panel mainPanel) {
		val editorPanel = new Panel(mainPanel)
		editorPanel.layout = new ColumnLayout(2)

		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Nombre", "nombre")
		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Apellido", "apellido")

		new Label(editorPanel) => [
			text = "DNI (sin puntos)"
			foreground = Color.BLUE
		]

		new NumericField(editorPanel) => [
			// Hay que validad el formato
			value <=> "clienteSeleccionado.dni"
			width = 200
		]

		new Label(editorPanel) => [
			text = "Mail"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			// Hay que validar el formato
			value <=> "clienteSeleccionado.mail"
			width = 200
		]

		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Teléfono", "telefono")
		createGridActions(editorPanel)
	}

	def void createGridActions(Panel mainPanel) {

		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			setAsDefault
			disableOnError
			alignCenter
		]

		new Button(mainPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
			alignCenter
		]
	}

}
