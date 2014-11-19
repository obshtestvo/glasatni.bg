promeni.controller("ThemeShowController", ["$scope", "$routeParams", "$http", function($scope, $routeParams, $http) {

  $http.get("/api/v1/themes/" + $routeParams.id).success(function(theme) {
    $scope.theme = theme;
  });

  $scope.proposal = [];

}]);

promeni.controller("ThemeIndexController", ["$scope", "$http", function($scope, $http) {

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
  }

  $http.get("/api/v1/themes").success(function(themes) {
    $scope.meta = themes.filter(function(t) { return t.en_name === "meta" })[0];
    $scope.themes = shuffle(themes.filter(function(t) { return t.en_name !== "meta" }));
  });

}]);
