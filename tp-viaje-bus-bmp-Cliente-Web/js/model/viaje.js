class Viaje {

    constructor() {
            this.fechaPartida = new Date()
            this.fechaLlegada = new Date()
            this.micro = new Micro()
            this.servicios = []
            this.recorrido = []
            this.pasajes = []
            this.asientos = []
    }

    precio(){
        if (this.fechaPartida === null || this.fechaLlegada === null){
            return 0
        }
         return precioBase + precioServicios// + precioMicro + precioFinde
    }

    precioBase(){
        return minutos * 2
    }

    minutos(){
        if (this.fechaPartida === null || this.fechaLlegada === null){
            return 0
        } else {
            let milisegundos = this.fechaLlegada.getTime() - this.fechaPartida.getTime()
            return Math.round(milisegundos / 60000)
        }
    }

    precioServicios(){
        let res = 0
        for(servicio in this.servicios){
            res += servicio.precio
        }


    }

}
