package ar.edu.unq.viajebus.ui

import applicationModel.ViajeAppModel
import ar.edu.unq.viajebus.Micro.Viaje
import java.awt.Color
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.joda.time.LocalDateTime
import applicationModel.BuscadorViajesAppModel
import applicationModel.PasajeAppModel

class BuscarViajesWindow extends TransactionalDialog<BuscadorViajesAppModel> {

new(WindowOwner parent, BuscadorViajesAppModel model) {
		super(parent,model)}
	


	override def createMainTemplate(Panel mainPanel) {
		title = "Viaje Bus"
		taskDescription = "Buscar Viaje"
		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		this.createGridActions(mainPanel)
	}

	def static crearLabelYTextBox(Panel panel, String texto, String valor) {
		new Label(panel) => [
			text = texto
			foreground = Color.BLUE
		]

		new TextBox(panel) => [
			value <=> valor
			width = 200

		]
	}

	override protected createFormPanel(Panel mainPanel) {

		val searchFormPanel = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		crearLabelYTextBox(searchFormPanel, "Ciudad:", "ciudadSeleccionada")
		crearLabelYTextBox(searchFormPanel, "Partida:", "fechaPartidaSeleccionada")
		crearLabelYTextBox(searchFormPanel, "Llegada:", "fechaLlegadaSeleccionada")
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Buscar"
			onClick[modelObject.search]
			setAsDefault
			disableOnError
		]
	}

	def createResultsGrid(Panel mainPanel) {
		var table = new Table<Viaje>(mainPanel, Viaje) => [
			items <=> "resultadosViaje"
		 value <=> "exampleViaje"
		]
		this.describeResultsGrid(table)
	}

	def void describeResultsGrid(Table<Viaje> table) {

		new Column<Viaje>(table) => [
			title = "Partida"
			bindContentsToProperty("fechaPartida").transformer = [ LocalDateTime f |
				val dias = f.getDayOfMonth().toString
				val meses = f.getMonthOfYear().toString
				val anios = f.getYear().toString
				val res = '''«dias»/«meses»/«anios»'''
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
				val res = '''«dias»/«meses»/«anios»'''
				res
			]
			fixedSize = 200
		]

		new Column<Viaje>(table) => [
			title = "Micro"
			bindContentsToProperty("micro.patente")
			fixedSize = 100
		]

		new Column<Viaje>(table) => [
			title = "Precio"
			bindContentsToProperty("precio").transformer = [ double p |
				'''$«p»'''

			]
			fixedSize = 100
		]
	}

	def void createGridActions(Panel mainPanel) {

		val actionsPanel = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(actionsPanel) => [
			caption = "Aceptar"
			onClick[this.accept]
			disableOnError
		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick[this.cancel]
		]
		
	}

}
