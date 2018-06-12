class SeleccionarAsientoController {
    constructor($stateParams, $state, PagosMercadoService, viajeService, pasajeService, BarraSuperiorService, growl) {
        this.$stateParams = $stateParams
        this.state = $state
        this.pagosMercado = PagosMercadoService
        this.viajeService = viajeService
        this.pasajeService = pasajeService
        this.barraSuperiorService = BarraSuperiorService
        this.viaje = new Viaje()
        this.pasaje = new Pasaje()
        this.buscarViaje()
        this.asientos = []
        this.growl = growl
        this.errorHandler = (response) => {
            if (response.data.errors) {
                let error = response.data.errors[0].detail.toString()
                this.notificarError(error)
            }
            if (response.data.error) {
                this.notificarError(response.data.error)
            }
        }
    }

    // NOTIFICACIONES & ERRORES
    notificarMensaje(mensaje) {
        this.growl.info(mensaje)
    }

    notificarError(mensaje) {
        this.growl.error(mensaje)
    }

    asientoReservado(asiento) {
        return asiento.estado.nombre == "Reservado"
    }

    buscarViaje() {
        this.viajeService.getViajeById(this.$stateParams.id)
            .then((response) => {
                this.viaje = response.data
                this.asientos = this.viaje.asientos
            }, this.errorHandler)
    }

    esCama(viaje) {
        return viaje.micro.tipoAsiento.nombre == "Cama"
    }

    tieneServicios(viaje) {
        return viaje.servicios.length > 0
    }

    mostrarServicios(viaje) {
        return viaje.servicios.join(", ")
    }


    registrarPago() {
        this.pasaje.viajeId = this.viaje.id
        this.pasaje.username = this.barraSuperiorService.usuarioLogueado.username
        this.pasaje.password = this.barraSuperiorService.usuarioLogueado.password
        this.pasaje.pago.amount = this.viaje.precio
        this.pagosMercado
            .iniciarPago(this.pasaje.pago)
            .then((it) => this.pasajeService.crearPago(this.pasaje, it.data.token))
            .then((it) => {
                this.notificarMensaje("Pasaje a " + this.viaje.ciudadDestino + " comprado con éxito")
                this.state.go("buscarViajes")
            }, this.errorHandler)
    }


}