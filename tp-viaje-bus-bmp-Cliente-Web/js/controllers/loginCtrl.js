  class LoginController {

    constructor($stateParams, $state, UsuarioService, LoginService) {
      this.usuariosService = UsuarioService
      this.loginService = LoginService
      this.usuario = new Usuario()
      this.errorMessage = ''
      this.usuarios = UsuarioService.usuarios
      this.state = $state
      this.usuarioLogueado = this.loginService.usuarioLogueado
    }

    
    agregarUsuario(registerForm) {
      try {
        this.errorMessage = ''
        this.usuario.validarRegistro()
        this.usuariosService.agregarUser(this.usuario)
        this.state.go("login")
      } catch (exception) {
        registerForm.$invalid = true
        this.errorMessage = exception
      }
    }

    loginUsuario(loginForm){
      try {
        this.errorMessage = ''
        this.usuariosService.validarLogin(this.usuario)
        this.acceder()
      } catch (exception) {
        loginForm.$invalid = true
        this.errorMessage = exception
      }
    }
    
     acceder(){
       this.loginService.usuarioLogueado = this.usuario
       this.state.go("buscarViajes")
       console.log("accediendo")
     }

  }