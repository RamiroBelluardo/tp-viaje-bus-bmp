angular.module('viajeBusApp', ['ui.router', 'ui.bootstrap', 'angular-growl'])
    .config(['growlProvider', function (growlProvider) {
        growlProvider.globalTimeToLive(2000);
    }])
    .service("UsuarioService", UsuarioService)
    .service("viajeService", viajeService)
    .service("BarraSuperiorService", BarraSuperiorService)
    .controller('LoginController', LoginController)
    .controller('RegisterController', RegisterController)
    .controller('BarraSuperiorController', BarraSuperiorController)
    .controller('BuscarViajesController', BuscarViajesController)
    .config(routes)