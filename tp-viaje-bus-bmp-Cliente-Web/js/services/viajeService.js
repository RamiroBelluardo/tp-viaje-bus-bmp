const viajeService = ($http, $state) => {
  this.state = $state
  const baseurl = "http://localhost:9200/"
  return {
    listarTodos: () => {
      return $http({
        method: "GET",
        url: baseurl + "viajes"
      })
    },
    listarActuales: () => {
      return $http({
        method: "GET",
        url: baseurl + "viajesActuales"
      })
    },
    buscar: (ciudadPartida, ciudadLlegada, fechaPartida, fechaLlegada) => {
      return $http({
        method: "GET",
        url: baseurl + "viajes?ciudadPartida=" + ciudadPartida + "&ciudadLlegada=" + ciudadLlegada + "&fechaPartida=" + fechaPartida + "&fechaLlegada=" + fechaLlegada
      })
    },
    getViajeById: (id) => {
      return $http({
        method: "GET",
        url: baseurl + "viaje/" + id
      })
    }
  }

}