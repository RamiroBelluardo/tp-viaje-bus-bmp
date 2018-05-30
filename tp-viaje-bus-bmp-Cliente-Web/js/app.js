angular.module('viajeBusApp', ['ui.router'])
    .service("UsuarioService", UsuarioService)
    .service("ViajeService", ViajeService)
    .controller('LoginController', LoginController)
    .controller('BuscarViajesController', BuscarViajesController)
    .config(routes)
    