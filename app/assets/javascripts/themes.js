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

  var select_theme_by_en_name = function(themes, en_name) {
    return themes.filter(function(t) { return t.en_name === en_name })[0];
  }

  var filter_themes_with_en_name = function(themes, en_name) {
    return themes.filter(function(t) { return t.en_name !== en_name })
  }

  $http.get("/api/v1/themes").success(function(themes) {
    $scope.participation_sofia = select_theme_by_en_name(themes, "participation_sofia")
    $scope.themes = shuffle(filter_themes_with_en_name(themes, "participation_sofia"));
  });

}]);
