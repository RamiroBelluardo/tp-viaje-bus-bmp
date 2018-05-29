  class LoginController {

    constructor(UsuarioService) {
      this.usuario = new Usuario()
      this.errorMessage = ''
    }

    // acceder(){
    //   this.state.go("buscarViajes")
    // }
    
    agregarUsuario(registerForm) {
      try {
        this.errorMessage = ''
        this.usuario.registrar()
      } catch (exception) {
        registerForm.$invalid = true
        this.errorMessage = exception
      }
    }
     

  }