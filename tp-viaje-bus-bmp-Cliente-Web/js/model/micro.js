class Micro {

    constructor() {
            this.patente = null
            this.tipoAsiento = new TipoAsiento()
            this.tieneTele = null
            this.cantidadAsientos = null
    }
}

class TipoAsiento {

    constructor() {
        this.nombre = ""
        this.porcentaje = 0
    }
}