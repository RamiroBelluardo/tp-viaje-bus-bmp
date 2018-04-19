package repo

import ar.edu.unq.viajebus.Cliente.Cliente

class RepoClientes {

	static RepoClientes instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoClientes
		}
		instance
	}

	// CLIENTE:  new(String nombre, String apellido, String dni, String mail, String telefono)
	def getClientes() {

		val cliente1 = new Cliente("Lucas", "Pier", "111111", "lg.piergiacomi@gmail.com", "44444444")

		#[cliente1]
	}
}
