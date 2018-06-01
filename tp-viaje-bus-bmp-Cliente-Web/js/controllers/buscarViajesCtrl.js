class BuscarViajesController {

    constructor(viajeService, growl) {
        this.viajeService = viajeService
        this.growl = growl
        this.viajes = []
        this.busqueda = ""
        this.fechaMinimaViaje = new Date()
        this.fechaPartidaAbierto = false
        this.fechaLlegadaAbierto = false
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
        const promise = (this.busqueda == "") ?
            this.viajeService.listarTodos() :
            this.viajeService.buscar(this.busqueda)

        promise
            .then((response) => response.data)
            .then((data) => this.viajes = data)
            .catch(this.errorHandler)
    }

    // LISTAR
    resetViajes() {
        this.busqueda = ""
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

    verAsientosLibres(viaje){
        return viaje.asientosLibres.length
    }

    ultimosDisponibles(viaje){
        return this.verAsientosLibres(viaje) < 5
    }

    mostrarTele(viaje){
        if (viaje.micro.tieneTele){
            return "Con tele"
        }
    }

    esCama(viaje){
        return viaje.micro.tipoAsiento.nombre == "Cama"
    }

    tieneServicios(viaje){
        return viaje.servicios.length > 0
    }

}