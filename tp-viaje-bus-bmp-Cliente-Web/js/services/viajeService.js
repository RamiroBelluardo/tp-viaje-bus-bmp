class ViajeService {

    constructor() {
      this.viajesIds = 0
      this.viajes = [] 
      let viaje1 = new Viaje()
      viaje1.fechaPartida = new Date()
      viaje1.fechaLlegada = new Date()
      viaje1.micro = new Micro()
      viaje1.servicios = []
      viaje1.recorrido = []
      viaje1.pasajes = []
      viaje1.asientos = []
      this.viajes.push(viaje1)
    }

    agregarViaje(viaje) {
        this.viajes.push(viaje)
        console.log(this.viajes)
    }
  
  }
  