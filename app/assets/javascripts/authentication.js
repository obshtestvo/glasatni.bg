glasatni.service("AuthService", ["$http", function($http) {
  var _user = null;

  this.login = function(email, password, remember_me) {
    $http.post("/users/sign_in.json", {
      user: { email: email, password: password, remember_me: remember_me }
    }).then(function (res) {
      _user = res.data;
    });
  };

  this.getUser = function() {
    return _user;
  };

  this.logout = function() {
    $http({ method: 'DELETE', url: "/users/sign_out.json", data: {} }).then(function() {
      _user = null;
    });
  };

}]);

glasatni.controller("LoginController", ["$scope", "$http", "AuthService", function($scope, $http, AuthService) {

  $scope.AuthService = AuthService;

}]);

glasatni.controller("NavigationController", ["$scope", "AuthService", function($scope, AuthService) {

  $scope.AuthService = AuthService;

}]);