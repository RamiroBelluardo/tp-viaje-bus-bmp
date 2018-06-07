const viajeService = ($http, $state) => {
  this.viajeAComprar = null
  this.state = $state
  const baseurl = "http://localhost:9200/"
  return {
    listarTodos: () => {
      return $http({
        method: "GET",
        url: baseurl + "viajes"
      })
    },
    buscar: (ciudadPartida, ciudadLlegada, fechaPartida, fechaLlegada) => {
      return $http({
        method: "GET",
        url: baseurl + "viajes?ciudadPartida=" + ciudadPartida + "&ciudadLlegada=" + ciudadLlegada + "&fechaPartida=" + fechaPartida + "&fechaLlegada=" + fechaLlegada
      })
    }
  }
}