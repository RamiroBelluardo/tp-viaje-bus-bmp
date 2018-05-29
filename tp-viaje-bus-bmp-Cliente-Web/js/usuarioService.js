class UsuarioService {

    constructor() {
      this.usuariosIds = 0
      this.usuarios = []  
    }

    agregarUser(usuario) {
        // VALIDA
        this.usuarios.push(usuario)
        console.log(this.usuarios)    
    }

    validarLogin(usuario){
        // VALIDA
        if (usuario.username === null || usuario.username === "") {
            throw "Debe ingresar un username"
        }
        if (usuario.password === null || usuario.password === "") {
            throw "Debe ingresar un password"
        }

        // Falta validar que el username exista, y que los datos sean correctos.
    }      
  
  }
  