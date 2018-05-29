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
      
  
  }
  