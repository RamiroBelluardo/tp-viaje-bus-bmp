angular.module('viajeBusApp', ['ui.router'])
    .service("UsuarioService", UsuarioService)
    .controller('LoginController', LoginController)
    .config(routes)
