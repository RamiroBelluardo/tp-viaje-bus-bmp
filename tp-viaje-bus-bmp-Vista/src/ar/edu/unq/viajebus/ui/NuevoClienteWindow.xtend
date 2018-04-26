package ar.edu.unq.viajebus.ui

import ar.edu.unq.viajebus.Cliente.Cliente
import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
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

		new Label(editorPanel) => [
			text = "Nombre"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			value <=> "clienteSeleccionado.nombre"
			width = 200
		]

		new Label(editorPanel) => [
			text = "Apellido"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			val elementSelected = new NotNullObservable("clienteSeleccionado.nombre")
			value <=> "clienteSeleccionado.apellido"
			width = 200
			bindEnabled(elementSelected)
		]

		new Label(editorPanel) => [
			text = "DNI (sin puntos)"
			foreground = Color.BLUE
		]

		new NumericField(editorPanel) => [
			val elementSelected = new NotNullObservable("clienteSeleccionado.apellido")
			value <=> "clienteSeleccionado.dni"
			width = 200
			bindEnabled(elementSelected)
		]

		new Label(editorPanel) => [
			text = "Mail"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			val elementSelected = new NotNullObservable("clienteSeleccionado.dni")
			value <=> "clienteSeleccionado.mail"
			width = 200
			bindEnabled(elementSelected)
		]

		new Label(editorPanel) => [
			text = "Teléfono"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			value <=> "clienteSeleccionado.telefono"
			width = 200
		]

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
