angular.module('PokemonClub').config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/', {
      templateUrl: 'assets/templates/home.html',
      controller: 'HomeController',
      controllerAs: 'home'
    })
    .when('/other', {
      templateUrl: 'assets/templates/other.html',
      controller: 'OtherController',
      controllerAs: 'other'
    })
    .when('/test', {
      templateUrl: 'assets/templates/test.html',
      controller: 'TestController',
      controllerAs: 'test'
    })
    .otherwise({
      redirectTo: '/'
    })
  return
])
