package ar.edu.unq.viajebus.ui

import applicationModel.BuscadorViajes
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

class BuscarViajesWindow extends TransactionalDialog<BuscadorViajes> {

	new(WindowOwner parent) {
		super(parent, new BuscadorViajes)
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Viaje Bus"
		taskDescription = "Buscar Viaje"
		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		this.createGridActions(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {
		val searchFormPanel = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]

		new Label(searchFormPanel) => [
			text = "Ciudad:"
			foreground = Color.BLUE
		]

		new TextBox(searchFormPanel) => [
			//value <=> "example.recorrido"
			width = 200
		]

		new Label(searchFormPanel) => [
			text = "Partida:"
			foreground = Color.BLUE
		]

		new TextBox(searchFormPanel) => [
			//value <=> "example.fechaPartida"
			width = 200
		]

		new Label(searchFormPanel) => [
			text = "Llegada:"
			foreground = Color.BLUE
		]

		new TextBox(searchFormPanel) => [
			//value <=> "example.fechaLlegada"
			width = 200
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Buscar"
			//onClick[modelObject.search]
			disableOnError
		]
	}

	def createResultsGrid(Panel mainPanel) {
		var table = new Table<Viaje>(mainPanel, Viaje) => [
			//items <=> "resultados"
			//value <=> "viajeSeleccionado"
		]
		this.describeResultsGrid(table)
	}

	def void describeResultsGrid(Table<Viaje> table) {
		new Column<Viaje>(table) => [
			title = "Partida"
			//bindContentsToProperty("fechaPartida")
			fixedSize = 200
		]

		new Column<Viaje>(table) => [
			title = "Destino"
			//bindContentsToProperty("destino")
			fixedSize = 200
		]

		new Column<Viaje>(table) => [
			title = "Micro"
			//bindContentsToProperty("micro")
			fixedSize = 100
		]

		new Column<Viaje>(table) => [
			title = "Precio"
			//bindContentsToProperty("precio")
			fixedSize = 100
		]
	}
	
	def void createGridActions(Panel mainPanel){
		
		val actionsPanel = new Panel(mainPanel).layout = new HorizontalLayout
		
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

}
