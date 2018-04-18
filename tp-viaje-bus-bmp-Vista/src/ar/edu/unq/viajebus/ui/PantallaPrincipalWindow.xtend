package ar.edu.unq.viajebus.ui

import applicationModel.PrincipalAppModel
import ar.edu.unq.viajebus.Micro.Viaje
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import ar.edu.unq.viajebus.Micro.Pasaje
import org.uqbar.arena.windows.Dialog
import org.joda.time.LocalDateTime


import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*


class PantallaPrincipalWindow extends SimpleWindow<PrincipalAppModel> {

	new(WindowOwner parent) {
		super(parent, new PrincipalAppModel)
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Viaje Bus"
		new Label(mainPanel) => [
			text = "Viajes"
			alignLeft
			fontSize = 20
		]

		var panelViajes = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]

		new Label(mainPanel) => [
			text = "Pasajes"
			alignLeft
			fontSize = 20
		]
		var panelPasajes = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]

		this.crearTablaViajes(panelViajes)
		this.crearBotonesViajes(panelViajes)

		this.crearTablaPasajes(panelPasajes)
		this.crearBotonesPasajes(panelPasajes)

	}

	def crearTablaViajes(Panel mainPanel) {

		var table = new Table<Viaje>(mainPanel, Viaje) => [
			items <=> "viajes"
			//value <=> "viajeSeleccionado"
			numberVisibleRows = 5
		]
		this.crearColumnasViaje(table)
	}

	def void crearColumnasViaje(Table<Viaje> table) {

		new Column<Viaje>(table) => [
			title = "Partida"
			bindContentsToProperty("fechaPartida").transformer = [ LocalDateTime f |
				val dias = f.getDayOfMonth().toString
				val meses = f.getMonthOfYear().toString
				val anios = f.getYear().toString
				val res = '''�dias�/�meses�/�anios�'''
				res
			]
			fixedSize = 200
		]

		new Column<Viaje>(table) => [
			title = "Destino"
			bindContentsToProperty("fechaLlegada").transformer = [ LocalDateTime f |
				val dias = f.getDayOfMonth().toString
				val meses = f.getMonthOfYear().toString
				val anios = f.getYear().toString
				val res = '''�dias�/�meses�/�anios�'''
				res
			]
			fixedSize = 200
		]

		new Column<Viaje>(table) => [
			title = "Micro"
			bindContentsToProperty("micro.patente")
			fixedSize = 120
		]

		new Column<Viaje>(table) => [
			title = "Precio"
			bindContentsToProperty("precio").transformer = [double p |
				'''$�p�'''
			]
			fixedSize = 115
		]

		new Column<Viaje>(table) => [
			title = "Vendido"
			bindContentsToProperty("micro.porcentajeVendido").transformer = [int p |
				'''�p�%'''
			]
			fixedSize = 115
		]
	}

	def crearTablaPasajes(Panel mainPanel) {

		var table = new Table<Pasaje>(mainPanel, Pasaje) => [
			// items <=> "pasajes"
			// value <=> "pasajeSeleccionado"
			numberVisibleRows = 5
		]
		this.crearColumnasPasaje(table)
	}

	def void crearColumnasPasaje(Table<Pasaje> table) {

		new Column<Pasaje>(table) => [
			title = "Cliente"
			//bindContentsToProperty("cliente")
			fixedSize = 150
		]

		new Column<Pasaje>(table) => [
			title = "Partida"
			//bindContentsToProperty("viaje.fechaPartida")
			fixedSize = 200
		]

		new Column<Pasaje>(table) => [
			title = "Llegada"
			//bindContentsToProperty("viaje.fechaLlegada")
			fixedSize = 200
		]

		new Column<Pasaje>(table) => [
			title = "Hora Partida"
			// bindContentsToProperty("horaPartida")
			fixedSize = 75
		]

		new Column<Pasaje>(table) => [
			title = "Asiento"
			// bindContentsToProperty("nroAsiento")
			fixedSize = 50
		]

		new Column<Pasaje>(table) => [
			title = "Pago"
			// bindContentsToProperty("tipoPago")
			fixedSize = 75
		]
	}

	def crearBotonesViajes(Panel mainPanel) {
		val panelButtons = new Panel(mainPanel)
		panelButtons.layout = new VerticalLayout
		new Button(panelButtons) => [
			caption = "Crear"
			onClick[crearViaje]
			
		]
		new Button(panelButtons) => [
			caption = "Editar"
			onClick[editarViaje]
		]
		new Button(panelButtons) => [
			caption = "Eliminar"
		]
	}

	def crearBotonesPasajes(Panel mainPanel) {
		val panelButtons = new Panel(mainPanel)
		panelButtons.layout = new VerticalLayout
		new Button(panelButtons) => [
			caption = "Crear"
			onClick[crearPasaje]
		]
		new Button(panelButtons) => [
			caption = "Ver"
			onClick[verPasaje]
		]
		new Button(panelButtons) => [
			caption = "Cancelar"
		]
	}

	def crearPasaje() {
		openDialog(new CrearPasajeWindow(this))
	}

	def verPasaje() {
		openDialog(new VerPasajeWindow(this))
	}
	def crearViaje() {
		openDialog(new CrearViajeWindow(this))
	}
	def editarViaje(){
		openDialog(new EditarViajeWindow(this))
	}
	def static openDialog(Dialog<?> dialog) {
		dialog.open
	}

	override protected addActions(Panel actionsPanel) {
	}

}
