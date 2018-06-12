package ar.edu.unq.viajebus.xtrest

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DatosPago {
	String card_number
	Integer amount
	Integer expiration_month
	Integer expiration_year
}