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
import ar.edu.unq.viajebus.Cliente.Cliente
import org.uqbar.arena.bindings.NotNullObservable

class NuevoClienteWindow extends TransactionalDialog<Cliente> {

	new(WindowOwner parent, Cliente cliente) {
		super(parent, cliente)
	}


	override protected createFormPanel(Panel mainPanel) {
		val editorPanel = new Panel(mainPanel)
		editorPanel.layout = new ColumnLayout(2)

		new Label(editorPanel) => [
			text = "Nombre"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			value <=> "nombre"
			width = 200
		]
		
		new Label(editorPanel) => [
			text = "Apellido"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			val elementSelected = new NotNullObservable("nombre")
			value <=> "apellido"
			width = 200
			bindEnabled(elementSelected)	
		]


		new Label(editorPanel) => [
			text = "DNI (sin puntos)"
			foreground = Color.BLUE
		]

		new NumericField(editorPanel) => [
			val elementSelected = new NotNullObservable("apellido")
			value <=> "dni"
			width = 200
			bindEnabled(elementSelected)		
		]

		new Label(editorPanel) => [
			text = "Mail"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			val elementSelected = new NotNullObservable("dni")
			value <=> "mail"
			width = 200
			bindEnabled(elementSelected)		
		]

		new Label(editorPanel) => [
			text = "Teléfono"
			foreground = Color.BLUE
		]

		new TextBox(editorPanel) => [
			value <=> "telefono"
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
			bindEnabledToProperty("valido")
			alignCenter
		]

		new Button(mainPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
			alignCenter
		]
	}

}
