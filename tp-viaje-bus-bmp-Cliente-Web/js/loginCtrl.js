  class LoginController {

    constructor($stateParams, $state){//, UsuarioService) {
      //this.usuariosService = UsuarioService
      this.usuariosService = new UsuarioService()
      this.usuario = new Usuario()
      this.errorMessage = ''
      this.usuarios = UsuarioService.usuarios
      this.state = $state
    }

    
    agregarUsuario(registerForm) {
      try {
        this.errorMessage = ''
        this.usuario.validarRegistro()
        this.usuariosService.agregarUser(this.usuario)
        this.acceder()
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
       //this.state.go("buscarViajes")
       console.log("accediendo")
     }

  }