class PagosController {

  constructor(PagosMercadoService, ApiService) {
    this.pagosMercado = PagosMercadoService
    this.api = ApiService
    this.nuevoPasaje()
  }

  nuevoPasaje() {
    this.pasaje = new Pasaje()
  }


  registrarPago() {
    this.pagosMercado
      .iniciarPago(this.pasaje.pago)
      .then((it) => this.api.crearPago(this.pasaje, it.data.token))
      .then(() => this.nuevoPasaje())
  }
}