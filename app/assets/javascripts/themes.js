promeni.controller("ThemeShowController", ["$scope", "$routeParams", "$http", function($scope, $routeParams, $http) {

  $http.get("/api/v1/themes/" + $routeParams.id).success(function(theme) {
    $scope.theme = theme;
  });

  $scope.proposal = [];

}]);

promeni.controller("ThemeIndexController", ["$scope", "$http", function($scope, $http) {

  $scope.order = ["education", "participation", "volunteering", "ngo"];

  $http.get("/api/v1/themes").success(function(themes) {
    $scope.meta = themes.filter(function(t) { return t.en_name === "meta" })[0];
    $scope.themes = themes.filter(function(t) { return t.en_name !== "meta" });
  });

}]);
