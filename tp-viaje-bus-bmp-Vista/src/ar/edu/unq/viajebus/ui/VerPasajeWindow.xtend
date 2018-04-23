package ar.edu.unq.viajebus.ui

import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Pasaje
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoClientes

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class VerPasajeWindow extends TransactionalDialog<Pasaje> {

	new(WindowOwner parent, Pasaje model) {
		super(parent, model)
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

		new Selector<Cliente>(panelIzquierdo) => [
			allowNull = false
			value <=> "cliente"
			val propiedadClientes = bindItems(new ObservableProperty(repoClientes, "clientes"))
			propiedadClientes.adaptWith(typeof(Cliente), "nombre")
			// value <=> "microSeleccionado"
			width = 150
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
		openDialog(new NuevoClienteWindow(this))
	}
	def buscarViaje() {
		openDialog(new BuscarViajesWindow(this)=> [
			
			open
		]
	)
	}

	def static openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def getRepoClientes() {
		ApplicationContext.instance.getSingleton(Cliente) as RepoClientes
	}

}
