class RegisterController {

  constructor($state, UsuarioService) {
    this.usuariosService = UsuarioService
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
      this.state.go("login")
    } catch (exception) {
      registerForm.$invalid = true
      this.errorMessage = exception
    }
  }

}