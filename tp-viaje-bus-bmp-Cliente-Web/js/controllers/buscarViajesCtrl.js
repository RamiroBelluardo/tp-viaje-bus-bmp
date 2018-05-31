class BuscarViajesController {

    constructor($stateParams, $state, ViajeService){
      this.fechaPartida = new Date()
      this.fechaLlegada = new Date()
      this.ciudadPartida = null
      this.ciudadLlegada = null
      this.viajeService = ViajeService
      this.viaje = new Viaje()
      this.fechaMinimaViaje = new Date()
      this.fechaPartidaAbierto = false
      this.fechaLlegadaAbierto = false
      this.errorMessage = ''
      this.viajes = ViajeService.viajes
      this.state = $state

    }
  
  verFechaPartida($event) {
		$event.preventDefault()
    $event.stopPropagation()
    this.fechaPartidaAbierto = true
  }
  
  verFechaLlegada($event) {
		$event.preventDefault()
    $event.stopPropagation()
    this.fechaLlegadaAbierto = true
	}

    agregarViaje() {
      this.viajeService.agregarViaje(this.viaje)
    }

  }