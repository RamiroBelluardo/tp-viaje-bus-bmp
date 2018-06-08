class SeleccionarAsientoController {

    constructor($state, viajeService, growl) {
        this.state = $state
        this.viajeService = viajeService
        this.growl = growl
        this.viajeAComprar = this.viajeService.viajeAComprar
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

    esCama(viaje) {
        return viaje.micro.tipoAsiento.nombre == "Cama"
    }

    tieneServicios(viaje) {
        return viaje.servicios.length > 0
    }

    mostrarServicios(viaje) {
        return viaje.servicios.join(", ")
    }

    mostrarTele(viaje) {
        return "Con tele"
    }
}