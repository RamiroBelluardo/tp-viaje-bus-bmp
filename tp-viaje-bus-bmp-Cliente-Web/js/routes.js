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
      url: "/seleccionarAsiento",
      templateUrl: "partials/seleccionarAsiento.html"
    })

  $urlRouterProvider.otherwise("/login");

}