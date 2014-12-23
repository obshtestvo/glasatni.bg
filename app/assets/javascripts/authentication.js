glasatni.service("AuthService", ["$http", "$q", function($http, $q) {
  var _user = null;
  var d = $q.defer();

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

  this.getUserFromServer = function() {
    return $http.get("/me").then(function(res) {
      _user = res.data === "null" ? null : res.data;
      d.resolve();
    });
  };

  this.userIsFetchedFromServer = d.promise;

}]);

glasatni.controller("LoginController", ["$scope", "AuthService", function($scope, AuthService) {

  $scope.AuthService = AuthService;

}]);

glasatni.controller("NavigationController", ["$scope", "AuthService", function($scope, AuthService) {

  $scope.AuthService = AuthService;

}]);