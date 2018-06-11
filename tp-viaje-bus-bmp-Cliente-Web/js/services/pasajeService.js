const pasajeService = ($http) => {
    const baseurl = "http://localhost:9200/"
    return {
      listarTodos: (username) => {
        return $http({
          method: "GET",
          url: baseurl + "pasajes/" + username
        })
      },
      cancelar: (pasaje) => {
        return $http({
          method: "POST",
          url: baseurl + "pasajes/" + pasaje.id + "/cancelar",
          data: pasaje
        })
      },
      confirmar: (pasaje) => {
        return $http({
          method: "POST",
          url: baseurl + "pasajes",
          data: pasaje
        })
      }
    }
  }