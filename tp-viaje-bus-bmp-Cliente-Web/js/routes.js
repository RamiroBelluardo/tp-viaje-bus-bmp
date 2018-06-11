const routes = ($stateProvider, $urlRouterProvider) => {


  $stateProvider
    .state('login', {
      url: "/login",
      templateUrl: "partials/login.html"
    })
    .state('register', {
      url: "/register",
      templateUrl: "partials/register.html"
    })
    .state('buscarViajes', {
      url: "/buscarViajes",
      templateUrl: "partials/buscarViajes.html"
    })
    .state('seleccionarAsiento', {
      url: "/viaje/:id",
      templateUrl: "partials/seleccionarAsiento.html"
    })
    .state('datosPersonales', {
      url: "/datosPersonales",
      templateUrl: "partials/datosPersonales.html"
    })

  $urlRouterProvider.otherwise("/login");

}