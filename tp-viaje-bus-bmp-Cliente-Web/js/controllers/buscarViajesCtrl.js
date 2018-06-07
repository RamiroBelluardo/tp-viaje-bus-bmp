class BuscarViajesController {

    constructor(viajeService, growl) {
        this.viajeService = viajeService
        this.growl = growl
        this.viajes = []
        this.ciudadPartida = ""
        this.ciudadLlegada = ""
        this.fechaPartida = new Date()
        this.fechaPartidaModificada = ""
        this.fechaLlegada = new Date()
        this.fechaLlegadaModificada = ""
        this.fechaMinimaViaje = new Date()
        this.fechaPartidaAbierto = false
        this.fechaLlegadaAbierto = false
        this.viajeAComprar = this.viajeService.viajeAComprar
        this.errorHandler = (response) => {
            if (response.data) {
                this.notificarError(response.data.error)
            } else {
                this.notificarError("Error de conexión, intente nuevamente luego.")
            }
        }
        this.resetViajes()

    }

    // NOTIFICACIONES & ERRORES
    notificarMensaje(mensaje) {
        this.growl.info(mensaje)
    }

    notificarError(mensaje) {
        this.growl.error(mensaje)
    }


    // BUSCAR
    buscarViajes() {
        if (this.fechaPartida !== null) {
            let diaPartida = this.fechaPartida.getDate()
            let mesPartida = this.fechaPartida.getMonth() + 1
            let anioPartida = this.fechaPartida.getFullYear()
            if (diaPartida < 10) {
                diaPartida = "0" + diaPartida
            }
            if (mesPartida < 10) {
                mesPartida = "0" + mesPartida
            }
            this.fechaPartidaModificada = diaPartida + "-" + mesPartida + "-" + anioPartida
        }
        if (this.fechaLlegada !== null) {
            let diaLlegada = this.fechaLlegada.getDate()
            let mesLlegada = this.fechaLlegada.getMonth() + 1
            let anioLlegada = this.fechaLlegada.getFullYear()
            if (diaLlegada < 10) {
                diaLlegada = "0" + diaLlegada
            }
            if (mesLlegada < 10) {
                mesLlegada = "0" + mesLlegada
            }
            this.fechaLlegadaModificada = diaLlegada + "-" + mesLlegada + "-" + anioLlegada
        }
        const promise = (this.ciudadPartida == "" && this.ciudadLlegada == "" && this.fechaPartida == null && this.fechaLlegada == null) ?
            this.viajeService.listarTodos() :
            this.viajeService.buscar(this.ciudadPartida, this.ciudadLlegada, this.fechaPartidaModificada, this.fechaLlegadaModificada)

        promise
            .then((response) => response.data)
            .then((data) => this.viajes = data)
            .catch(this.errorHandler)
    }

    // COMPRAR
    comprar(viaje) {
        console.log(this.viajeAComprar) // undefined la 1ra vez
        this.viajeService.viajeAComprar = viaje
        this.viajeAComprar = this.viajeService.viajeAComprar
//        this.viajeAComprar.micro = new Micro()
        console.log(this.viajeAComprar) // viaje a comprar realmente
        this.viajeService.comprar()
    }


    // LISTAR
    resetViajes() {
        this.ciudadPartida = ""
        this.ciudadLlegada = ""
        this.fechaPartida = null
        this.fechaLlegada = null
        this.buscarViajes()
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

    verAsientosLibres(viaje) {
        return viaje.asientosLibres.length
    }

    ultimosDisponibles(viaje) {
        return this.verAsientosLibres(viaje) < 5
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