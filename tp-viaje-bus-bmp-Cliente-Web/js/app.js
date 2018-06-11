angular.module('viajeBusApp', ['ui.router', 'ui.bootstrap', 'angular-growl'])
    .config(['growlProvider', function (growlProvider) {
        growlProvider.globalTimeToLive(2000);
    }])
    .factory("usuarioService", usuarioService)
    .factory("viajeService", viajeService)
    .factory("pasajeService", pasajeService)
    .service("BarraSuperiorService", BarraSuperiorService)
    .controller('BarraSuperiorController', BarraSuperiorController)
    .controller('LoginController', LoginController)
    .controller('RegisterController', RegisterController)
    .controller('BuscarViajesController', BuscarViajesController)
    .controller('PasajeController', PasajeController)
    .controller('UsuarioController', UsuarioController)
    .controller('SeleccionarAsientoController', SeleccionarAsientoController)
    .config(routes)


    