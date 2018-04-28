package ar.edu.unq.viajebus.ui

import applicationModel.PasajeAppModel
import ar.edu.unq.viajebus.Cliente.Cliente
import ar.edu.unq.viajebus.Micro.Asiento
import ar.edu.unq.viajebus.Micro.Micro
import ar.edu.unq.viajebus.Micro.Pasaje
import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoClientes
import repo.RepoMicros
import repo.RepoViajes
import transformer.ViajeTransformer

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class VerPasajeWindow extends TransactionalDialog<PasajeAppModel> {

	new(WindowOwner parent, Pasaje model) {
		super(parent, createViewModel(model))
		title = "Viaje Bus"
	}

	static def createViewModel(Pasaje pasaje) {
		val model = new PasajeAppModel()
		model.pasajeSeleccionado = pasaje
		return model
	}

	override protected createFormPanel(Panel mainPanel) {

		val panelCliente = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelCliente) => [
			text = "Cliente"
			fontSize = 15
		]

		new Button(panelCliente) => [
			caption = "Nuevo"
			width = 100
			enabled <=> "pasajeSeleccionado.noTieneCliente"
			onClick[nuevoCliente]
		]

		new Selector<Cliente>(panelCliente) => [
			allowNull = false
			enabled <=> "pasajeSeleccionado.noTieneCliente"
			value <=> "pasajeSeleccionado.cliente"
			val propiedadClientes = (items <=> "resultadosClientes") //bindItems(new ObservableProperty(repoClientes, "clientes"))
			propiedadClientes.adaptWith(typeof(Cliente), "nombreCompleto")
			width = 100
		]

		val panelViaje = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelViaje) => [
			text = "Viaje"
			fontSize = 15
		]

		new Button(panelViaje) => [
			caption = "Buscar"
			enabled <=> "pasajeSeleccionado.noTieneCliente"
			onClick[buscarViaje]
			width = 100
		]

		new Label(panelViaje) => [
			(value <=> "pasajeSeleccionado.viaje").transformer = new ViajeTransformer
		]

		val panelAsiento = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new Label(panelAsiento) => [
			text = "Asiento:"
			fontSize = 15
		]

		new Label(panelAsiento) => [
			value <=> "pasajeSeleccionado.nroAsiento"
			fontSize = 15
		]

		crearAsientos(panelAsiento)

		val panelPrecios = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]
		new Label(panelPrecios) => [
			text = "Precio:"
			fontSize = 15
		]

		new Label(panelPrecios) => [
			value <=> "pasajeSeleccionado.viaje.precio"
			fontSize = 15
		]

		createGridActions(mainPanel)

	}

	def void createGridActions(Panel panel) {

		val actionsPanel = new Panel(panel).layout = new ColumnLayout(4)

		new Button(actionsPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			onAccept[modelObject.pasajeSeleccionado.confirmar]
			setAsDefault
			disableOnError

		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
		]
	}

	def crearAsientos(Panel panel) {
		new Selector<Asiento>(panel) => [
			allowNull = false
			value <=> "pasajeSeleccionado.asiento"
			enabled <=> "pasajeSeleccionado.noTieneCliente"
			val propiedadAsientos = (items <=> "pasajeSeleccionado.viaje.micro.asientosDisponibles")
			propiedadAsientos.adaptWith(typeof(Asiento), "numero")
			width = 50

		]
	}

	def nuevoCliente() {
		val cliente = new Cliente
		new NuevoClienteWindow(this, cliente) => [
			onAccept[this.modelObject.crearCliente(cliente)]
			open

		]
	}

	def buscarViaje() {
		val pasaje = modelObject.pasajeSeleccionado
		new BuscarViajesWindow(this, pasaje) => [
			open
		]
	}

	def getRepoClientes() {
		ApplicationContext.instance.getSingleton(Cliente) as RepoClientes
	}

	def getRepoMicros() {
		ApplicationContext.instance.getSingleton(Micro) as RepoMicros
	}

	def getRepoViajes() {
		ApplicationContext.instance.getSingleton(Viaje) as RepoViajes
	}

}
