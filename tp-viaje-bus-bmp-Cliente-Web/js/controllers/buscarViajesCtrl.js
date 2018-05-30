class BuscarViajesController {

    constructor($stateParams, $state){
      this.usuariosService = new ViajeService()
      this.viaje = new Viaje()
      this.errorMessage = ''
      this.viajes = UsuarioService.viajes
      this.state = $state
    }


  }