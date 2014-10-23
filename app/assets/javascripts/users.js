promeni.controller("UserController", ["$scope", "$routeParams", "$http", function($scope, $routeParams, $http) {

  $http.get("/api/v1/users/" + $routeParams.id).success(function(user) {
    $scope.user = user;
  });

}]);

