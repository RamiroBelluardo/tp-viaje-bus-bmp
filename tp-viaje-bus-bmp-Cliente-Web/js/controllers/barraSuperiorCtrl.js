class BarraSuperiorController {

    constructor($state, BarraSuperiorService) {
      this.barraSuperiorService = BarraSuperiorService
      this.usuarioLogueado = this.barraSuperiorService.usuarioLogueado
    }

  }