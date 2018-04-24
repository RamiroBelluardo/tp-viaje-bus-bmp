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
import ar.edu.unq.viajebus.Cliente.Cliente

class NuevoClienteWindow extends TransactionalDialog<ClienteAppModel> {

	new(WindowOwner parent, Cliente cliente) {
		super(parent, createViewModel(cliente))
	}

	static def createViewModel(Cliente cliente) {
		val model = new ClienteAppModel()
		model.clienteSeleccionado = cliente
		return model
	}

	override protected createFormPanel(Panel mainPanel) {
		val editorPanel = new Panel(mainPanel)
		editorPanel.layout = new ColumnLayout(2)

		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Nombre", "clienteSeleccionado.nombre")
		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Apellido", "clienteSeleccionado.apellido")

		new Label(editorPanel) => [
			text = "DNI (sin puntos)"
			foreground = Color.BLUE
		]

		new NumericField(editorPanel) => [
			value <=> "clienteSeleccionado.dni"
			width = 200
		]

		new Label(editorPanel) => [
			text = "Mail"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			value <=> "clienteSeleccionado.mail"
			width = 200
		]

		BuscarViajesWindow.crearLabelYTextBox(editorPanel, "Teléfono", "clienteSeleccionado.telefono")
		createGridActions(editorPanel)
	}

	def void createGridActions(Panel mainPanel) {

		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			setAsDefault
			disableOnError
			bindEnabledToProperty("clienteSeleccionado.valido")
			alignCenter
		]

		new Button(mainPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
			alignCenter
		]
	}

}
