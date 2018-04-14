package ar.edu.unq.viajebus.ui

import applicationModel.ClienteAppModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import java.awt.Color
import ar.edu.unq.viajebus.ui.BuscarViajesWindow
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class NuevoClienteWindow extends Dialog<ClienteAppModel> {

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
			text = "DNI"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			// Hay que validad el formato
			// (value <=> "dni").transformer = new DNITransformer
			width = 200
		]

		new Label(editorPanel) => [
			text = "Mail"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			// Hay que validar el formato
			// (value <=> "mail").transformer = new MailTransformer
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
