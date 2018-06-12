angular.module('viajeBusApp', ['ui.router', 'ui.bootstrap', 'angular-growl'])
    .config(['growlProvider', function (growlProvider) {
        growlProvider.globalTimeToLive(4000);
    }])
    .factory("usuarioService", usuarioService)
    .factory("viajeService", viajeService)
    .factory("pasajeService", pasajeService)
    .service("PagosMercadoService", PagosMercadoService)
    .service("BarraSuperiorService", BarraSuperiorService)
    .controller("PagosController", PagosController)
    .controller('BarraSuperiorController', BarraSuperiorController)
    .controller('LoginController', LoginController)
    .controller('RegisterController', RegisterController)
    .controller('BuscarViajesController', BuscarViajesController)
    .controller('PasajeController', PasajeController)
    .controller('UsuarioController', UsuarioController)
    .controller('SeleccionarAsientoController', SeleccionarAsientoController)
    .config(routes)


    