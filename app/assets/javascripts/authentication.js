glasatni.service("AuthService", ["$http", "$q", "$location", "messageService", function($http, $q, $location, messageService) {
  var _user = null;
  var d = $q.defer();

  this.login = function(email, password, rememberMe, redirectTo) {
    messageService.removeByLocation('login');
    $http.post("/users/sign_in.json", {
      user: { email: email, password: password, remember_me: rememberMe }
    }).then(function (res) {
      _user = res.data;

      messageService.push({
        msg: "Успешно влязохте в своя профил.",
        type: "success",
        destination: "top message"
      });

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

  this.register = function(email, name, password, passwordConfirmation, bio, subscribed, redirectTo) {

    messageService.removeByLocation('register');

    $http.post("/users.json", {
      user: { email: email, name: name, password: password, password_confirmation: passwordConfirmation, bio: bio, subscribed: subscribed }
    }).then(function(res) { // on success

      messageService.push({
        msg: "Регистрацията приключи успешно",
        type: "success",
        destination: "top message"
      });

      _user = res.data;

      if (redirectTo) {
        $location.path(redirectTo);
      }

    }, function(response) { // on error

      for(wrongField in response.data.errors) {

        messageService.push({
          msg: wrongField + " " + response.data.errors[wrongField],
          type: "danger",
          destination: "register"
        });

      }
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