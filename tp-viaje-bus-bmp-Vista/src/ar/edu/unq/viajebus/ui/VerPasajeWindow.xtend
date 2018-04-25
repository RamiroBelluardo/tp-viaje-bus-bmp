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
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext
import repo.RepoClientes
import repo.RepoMicros

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
			value <=> "pasajeSeleccionado.cliente"
			val propiedadClientes = bindItems(new ObservableProperty(repoClientes, "clientes"))
			propiedadClientes.adaptWith(typeof(Cliente), "nombre")
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

		new Label(panelViaje) => [
			value <=> "viajeSeleccionado"
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
			value <=> "pasajeSeleccionado.nroAsiento"
			fontSize = 15
		]

		val panelAsientos = new Panel(panelDerecho)
		panelAsientos.layout = new ColumnLayout(8)
		crearAsientos(panelAsientos, repoMicros.micros.get(1).cantidadAsientos)

		createGridActions(panelDerecho)

	}

	def void createGridActions(Panel panel) {

		val actionsPanel = new Panel(panel).layout = new ColumnLayout(4)

		new Button(actionsPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			modelObject.pasajeSeleccionado.viaje = modelObject.viajeSeleccionado
			setAsDefault
			disableOnError

		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
		]
	}

	def crearAsientos(Panel panel, int nroAsientos) {
			new Selector<Asiento>(panel) => [
				allowNull = false
				value <=> "pasajeSeleccionado.nroAsiento"
				val propiedadAsientos = bindItems(new ObservableProperty(repoMicros.micros.get(1), "nrosAsientosDisponibles"))
				//propiedadAsientos.adaptWith(typeof(Integer), "numero")
				width = 100
			]
	}


	def nuevoCliente() {
		val cliente = new Cliente
		new NuevoClienteWindow(this, cliente) => [
			onAccept[this.modelObject.crearCliente(cliente)]
			open

		]
		modelObject.search

	}

	def buscarViaje() {

		val viaje = new Viaje
		val pasaje = new Pasaje

		new BuscarViajesWindow(this, viaje, pasaje) => [
			onAccept[this.modelObject.actualizarViajeSeleccionado(pasaje.viaje)]
			open
		]
	}

	def getRepoClientes() {
		ApplicationContext.instance.getSingleton(Cliente) as RepoClientes
	}
	
	def getRepoMicros() {
		ApplicationContext.instance.getSingleton(Micro) as RepoMicros
	}

}
