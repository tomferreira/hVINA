angular.module('hierarchie')
  .config(['$routeProvider',
    function($routeProvider) {
      $routeProvider.when('/', {
        templateUrl: 'charts',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
    }
  ]);
