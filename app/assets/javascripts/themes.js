glasatni.controller("ThemeShowController", ["$scope", "$routeParams", "$http", function($scope, $routeParams, $http) {

  $http.get("/api/v1/themes/" + $routeParams.id).success(function(theme) {
    $scope.theme = theme;
    $scope.section = theme.archived ? "archived" : "proposals"
  });

  $scope.order = typeof $scope.$root.order === "undefined" ? "newest" : $scope.$root.order;
  $scope.proposal = [];

}]);

glasatni.controller("ThemeIndexController", ["$scope", "$http", function($scope, $http) {

  // Fisher–Yates Shuffle http://bost.ocks.org/mike/shuffle/
  var shuffle = function(array) {
    var m = array.length, t, i;
    while (m) {
      i = Math.floor(Math.random() * m--);
      t = array[m];
      array[m] = array[i];
      array[i] = t;
    }
    return array;
  };

  $http.get("/api/v1/themes").success(function(themes) {
    $scope.themes = shuffle(themes);
  });

}]);
