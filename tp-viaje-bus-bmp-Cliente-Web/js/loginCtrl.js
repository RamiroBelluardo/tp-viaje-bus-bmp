  class LoginController {

    constructor(UsuarioService) {
        this.usuariosService = UsuarioService
        this.usuarios = UsuarioService.usuarios
    }


  }