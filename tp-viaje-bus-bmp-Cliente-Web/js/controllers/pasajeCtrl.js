class PasajeController {
    constructor(pasajeService, BarraSuperiorService, growl) {
        this.pasajeService = pasajeService
        this.barraSuperiorService = BarraSuperiorService
        this.pasajes = []
        this.growl = growl
        this.errorHandler = (response) => {
            if (response.data) {
                this.notificarError(response.data.error)
            } else {
                this.notificarError("Error de conexión, intente nuevamente luego.")
            }
        }
        this.resetPasajes()
    }

    // NOTIFICACIONES & ERRORES
    notificarMensaje(mensaje) {
        this.growl.info(mensaje)
    }

    notificarError(mensaje) {
        this.growl.error(mensaje)
    }

    // LISTAR
    resetPasajes() {
        let username = this.barraSuperiorService.usuarioLogueado.username
        const promise = this.pasajeService.listarTodos(username)
        promise
            .then((response) => response.data)
            .then((data) => this.pasajes = data)
            .catch(this.errorHandler)
    }

    // CANCELAR
    cancelar(pasaje) {
        const mensaje = "¿Está seguro que desea cancelar el pasaje con destino '" + pasaje.ciudadDestino + "'?"
        bootbox.confirm({
            message: mensaje,
            buttons: {
                confirm: {
                    label: 'Sí, cancelar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'No, me arrepentí',
                    className: 'btn-danger'
                }
            },
            callback: (confirma) => {
                if (confirma) {
                    this.pasajeService.cancelar(pasaje).then(() => {
                        this.notificarMensaje('Pasaje cancelado')
                        this.resetPasajes()
                    }, this.errorHandler)
                }
            }
        })
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

}