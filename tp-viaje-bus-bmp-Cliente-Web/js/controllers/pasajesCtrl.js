class PasajesController {
    constructor(pasajeService, BarraSuperiorService, growl) {
        this.pasajeService = pasajeService
        this.barraSuperiorService = BarraSuperiorService
        this.growl = growl
        this.pasajes = []
        this.username = this.barraSuperiorService.usuarioLogueado.username
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
        const promise = this.pasajeService.listarTodos(this.username)
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
        // const promise = this.pasajeService.cancelar(pasaje)
        // promise
        // this.notificarMensaje('Pasaje cancelado')
        // this.resetPasajes()
        //     .catch(this.errorHandler)
    // }
}