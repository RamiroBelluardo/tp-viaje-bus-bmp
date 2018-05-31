  class LoginController {

    constructor($state, UsuarioService, BarraSuperiorService) {
      this.usuariosService = UsuarioService
      this.barraSuperiorService = BarraSuperiorService
      this.usuario = new Usuario()
      this.errorMessage = ''
      this.usuarios = UsuarioService.usuarios
      this.state = $state
      this.usuarioLogueado = this.barraSuperiorService.usuarioLogueado
    }


    loginUsuario(loginForm){
      try {
        this.errorMessage = ''
        this.usuariosService.validarLogin(this.usuario)
        this.barraSuperiorService.usuarioLogueado = this.usuario
        this.acceder()
      } catch (exception) {
        loginForm.$invalid = true
        this.errorMessage = exception
      }
    }
    
     acceder(){
       this.state.go("buscarViajes")
       console.log("accediendo")
     }

  }