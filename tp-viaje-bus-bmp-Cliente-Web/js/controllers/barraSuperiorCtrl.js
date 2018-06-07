class BarraSuperiorController {

  constructor($state, BarraSuperiorService) {
    this.state = $state
    this.barraSuperiorService = BarraSuperiorService
    this.usuarioLogueado = this.barraSuperiorService.usuarioLogueado
  }

  abrirPerfil() {
    this.state.go("datosPersonales")
  }
}