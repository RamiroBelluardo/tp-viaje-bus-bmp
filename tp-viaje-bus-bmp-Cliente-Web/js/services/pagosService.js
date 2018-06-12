class PagosMercadoService {
    constructor($http) {
        this.http = $http
        this.base = "https://pagosmercado.herokuapp.com/"
    }

    iniciarPago(pago) {
        return this.http
            .post(this.base + "start-payment", pago)
            .then((res) => res.data)
    }
}