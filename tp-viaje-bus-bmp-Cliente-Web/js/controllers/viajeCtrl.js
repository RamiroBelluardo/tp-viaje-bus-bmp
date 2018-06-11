class ViajeController {
    constructor($stateParams, $state, viajeService, growl) {
        this.$stateParams = $stateParams
        this.state = $state
        this.viajeService = viajeService
        this.viaje = new Viaje()
        this.buscarViaje()
        this.asientos = []
        this.growl = growl
        this.errorHandler = (response) => {
            if (response.data) {
                this.notificarError(response.data.error)
            } else {
                this.notificarError("Error de conexión, intente nuevamente luego.")
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

    buscarViaje(){
        this.viajeService.getViajeById(this.$stateParams.id)
        .then((response) => {
            this.viaje = response.data
            this.asientos = this.viaje.asientos
        }, this.errorHandler)
    }

    mostrarTele(viaje) {
        if (viaje.micro.tieneTele) {
            return "Con tele"
        }
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

    mostrarRecorrido(viaje) {
        return viaje.recorrido.join(", ")
    }

    asientoReservado(asiento) {
        return asiento.estado.nombre == "Reservado"
    }

}