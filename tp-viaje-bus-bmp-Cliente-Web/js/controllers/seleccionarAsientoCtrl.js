class SeleccionarAsientoController {

    constructor($state, viajeService, pasajeService, BarraSuperiorService, growl) {
        this.state = $state
        this.viajeService = viajeService
        this.pasajeService = pasajeService
        this.barraSuperiorService = BarraSuperiorService
        this.growl = growl
        this.viajeAComprar = this.viajeService.viajeAComprar
        this.asientosLibres = this.viajeAComprar.asientosLibres
        this.cantidadAsientos = this.viajeAComprar.micro.cantidadAsientos
        this.pasajeAComprar = null
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

    asientos() {
        let res = []
        for (let i = 0; i < this.cantidadAsientos; i++) {
            res.push(i + 1)
        }
        return res
    }

    confirmar(){
        this.pasajeAComprar.username =this.barraSuperiorService.usuarioLogueado.username
        this.pasajeAComprar.password =this.barraSuperiorService.usuarioLogueado.password
        this.pasajeAComprar.viajeId = 1 // CAMBIARRRRRRRRRRRRRRRRRRRRRRR
        this.pasajeService.confirmar(this.pasajeAComprar)
    }
}