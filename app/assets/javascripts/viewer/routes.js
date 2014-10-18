angular.module('hierarchie')
  .config(['$routeProvider',
    function($routeProvider) {
      $routeProvider.when('/', {
        templateUrl: 'charts.html',
        controller: 'MainCtrl'
      })
        .otherwise({
          redirectTo: '/'
        });
    }
  ]);
