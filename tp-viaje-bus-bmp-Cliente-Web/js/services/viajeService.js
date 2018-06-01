const viajeService = ($http) => {
  const baseurl = "http://localhost:9200/"
  return {
    listarTodos: () => {
      return $http({
        method: "GET",
        url: baseurl + "viajes"
      })
    },
    buscar: (busqueda) => {
      return $http({
        method: "GET",
        url: baseurl + "viajes/search?ciudadPartida=" + busqueda
      })
    }
  }
}

