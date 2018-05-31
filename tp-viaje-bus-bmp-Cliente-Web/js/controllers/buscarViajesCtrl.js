class BuscarViajesController {

    constructor($stateParams, $state){
      this.fechaPartida = new Date()
      this.fechaLlegada = new Date()
      this.ciudadPartida = null
      this.ciudadLlegada = null
      this.viajeService = new ViajeService()
      this.viaje = new Viaje()
      this.fechaMinimaViaje = new Date()
      this.calendarioAbierto = false
      this.errorMessage = ''
      this.viajes = ViajeService.viajes
      this.state = $state

    }


	verCalendario($event) {
		$event.preventDefault()
		$event.stopPropagation()
    this.calendarioAbierto = true
	}

    agregarViaje() {
      this.viajeService.agregarViaje(this.viaje)
    }

  }