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
        const mensaje = "¿Está seguro que desea cancelar el pasaje con destino a <b>'" + pasaje.viaje.ciudadDestino + "'</b>, con número de asiento <b>'" + pasaje.asiento + "'</b>?<br><br><b><u>Nota:</u> No se le reintegrará el monto abonado de $" + pasaje.viaje.precio + "</b>"
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
                    let usuario = this.barraSuperiorService.usuarioLogueado
                    this.pasajeService.cancelar(usuario, pasaje)
                        .then((response) => {
                            this.notificarMensaje("Pasaje con destino a <b>'" + pasaje.viaje.ciudadDestino + "'</b>, y número de asiento <b>'" + pasaje.asiento + "'</b> cancelado con éxito")
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

    mostrarServicios(viaje) {
        return viaje.servicios.join(", ")
    }


}