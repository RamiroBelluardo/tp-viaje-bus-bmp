class UsuarioService {

    constructor() {
      this.usuariosIds = 0
      this.usuarios = []  
    }

    crearUsuario(username, password, name, lastName, dni, mail, phone) {
        let usuario = new Usuario(username, password, name, lastName, dni, mail, phone)
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
  