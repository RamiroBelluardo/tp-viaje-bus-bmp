class UsuarioService {

    constructor() {
      this.usuariosIds = 0
      this.usuarios = []  
    }

    crearUsuario(username, password) {
        let usuario = new Usuario(username, password)
        usuario.id = this.usuariosIds++
        return usuario
    }

    agregarUsuario(usuario) {
        this.usuarios.push(usuario)
    }

    getUsuarioById(id) {
        return this.usuarios.find((usuario) => {
          return usuario.id == id
        })
      }
      
  
  }
  