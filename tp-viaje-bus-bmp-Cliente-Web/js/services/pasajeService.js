const pasajeService = ($http) => {
  const baseurl = "http://localhost:9200/"
  return {
    listarActuales: (username) => {
      return $http({
        method: "GET",
        url: baseurl + "pasajes/" + username
      })
    },
    listarHistoricos: (username) => {
      return $http({
        method: "GET",
        url: baseurl + "pasajesHistoricos/" + username
      })
    },
    listarCancelados: (username) => {
      return $http({
        method: "GET",
        url: baseurl + "pasajesCancelados/" + username
      })
    },
    cancelar: (usuario, pasaje) => {
      return $http({
        method: "POST",
        url: baseurl + "pasajes/" + pasaje.id + "/cancelar",
        data: usuario,
        pasaje
      })
    },
    crearPago(pasaje, token) {
      let uri = baseurl + "pasajes?token=" + token
      return $http({
        method: "POST",
        url: uri,
        data: pasaje,
        token
      })

    }
  }
}