glasatni.service("AuthService", ["$http", "$q", "$location", "messageService", function($http, $q, $location, messageService) {
  var _user = null;
  var d = $q.defer();

  this.login = function(email, password, rememberMe, redirectTo) {
    $http.post("/users/sign_in.json", {
      user: { email: email, password: password, remember_me: rememberMe }
    }).then(function (res) {
      _user = res.data;

      messageService.removeByLocation('login');

      if(redirectTo) {
        $location.path(redirectTo);
      }
    }, function(error) {
      var msg;

      // change the error message if it is too ambiguous
      msg = error.status === 401 ? "Невалидна поща или парола." : error.data.error;

      messageService.push({
        msg: msg,
        type: "danger",
        destination: "login"
      });

    });
  };

  this.getUser = function() {
    return _user;
  };

  this.logout = function(redirectTo) {
    $http({ method: 'DELETE', url: "/users/sign_out.json", data: {} }).then(function() {
      _user = null;

      if(redirectTo) {
        $location.path(redirectTo);
      }
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