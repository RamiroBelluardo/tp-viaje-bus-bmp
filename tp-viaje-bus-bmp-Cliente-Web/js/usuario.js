class Usuario {

        constructor() {
                this.username = null
                this.password = null
                this.cliente = new Cliente()
        }

        registrar() {
                this.validar()
                // GUARDARSE AL USUARIO
        }

        validar() {
                if (this.username === null || this.username === "") {
                        throw "Debe ingresar un username"
                }
                if (this.username.length < 5) {
                        throw "El username debe tener 5 caracteres al menos"
                }

                if (this.password === null || this.password === "") {
                        throw "Debe ingresar un password"
                }

                if (this.password.length < 4) {
                        throw "El password debe tener 4 caracteres al menos"
                }
                this.cliente.validar()
        }

}

class Cliente {
        constructor() {
    
            this.name = null
            this.lastName = null
            this.dni = null
            this.mail = null
            this.phone = null
        }
    
        validar() {
            if (this.name === null || this.name === "") {
                throw "Debe ingresar nombre"
            }
            if (this.lastName === null || this.lastName === "") {
                throw "Debe ingresar apellido"
            }
            if (this.dni === null || this.dni === "") {
                throw "Debe ingresar dni"
            }
            if (this.mail === null || this.mail === "") {
                throw "Debe ingresar mail"
            }
            if (this.mail.length < 5) {
                throw "El mail debe tener 5 caracteres al menos"
            }
            if (!this.mail.includes("@") || this.mail.slice(-1) === "@") {
                    throw "El Mail debe contener un @ intermedio"
            }
        }
    }