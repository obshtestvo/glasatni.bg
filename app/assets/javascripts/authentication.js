glasatni.service("AuthService", ["$http", "$q", "$location", "messageService", function($http, $q, $location, messageService) {
  var _user = null;
  var d = $q.defer();
  var that = this;

  this.login = function(email, password, rememberMe, redirectTo) {

    messageService.removeByLocation('login');

    $http.post("/users/sign_in.json", {
      user: { email: email, password: password, remember_me: rememberMe }
    }).then(function (res) {
      _user = res.data;

      messageService.removeByLocation('top message');
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

      messageService.removeByLocation('login');
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
      user: {
        email: email,
        name: name,
        password: password,
        password_confirmation: passwordConfirmation,
        bio: bio,
        subscribed: subscribed
      }
    }).then(function(res) { // on success

      messageService.removeByLocation('top message');
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

      messageService.removeByLocation('register');
      for(wrongField in response.data.errors) {

        messageService.push({
          msg: wrongField + " " + response.data.errors[wrongField],
          type: "danger",
          destination: "register"
        });

      }
    });
  };

  this.updateUser = function(email, name, password, passwordConfirmation, bio, subscribed, currentPassword, redirectTo) {

    $http({
      method: "PATCH",
      data: {
        user : {
          email: email,
          name: name,
          password: password,
          password_confirmation: passwordConfirmation,
          bio: bio,
          subscribed: subscribed,
          current_password: currentPassword
        }
      },
      url: "/users.json"
    }).then(function(res) {

      messageService.removeByLocation('top message');
      messageService.push({
        msg: "Промените са направени успешно",
        type: "success",
        destination: "top message"
      });

      that.getUserFromServer();

      if (redirectTo) {
        $location.path(redirectTo);
      }

    }, function(response) {

      messageService.removeByLocation('register');
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

      messageService.removeByLocation('top message');
      messageService.push({
        msg: "Успешно излязохте от своя профил.",
        type: "success",
        destination: "top message"
      });
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

glasatni.controller("RegisterController", ["$scope", "AuthService", function($scope, AuthService) {

  $scope.AuthService = AuthService;
  $scope.page = {
    showCurrentPassword: false,
    title: "Регистрирай се",
    password: "Парола",
    button: "Хайде!"
  };

  $scope.user = {
    passwordConfirmation: ""
  };

  $scope.submit = function() {
    AuthService.register(
      $scope.user.email,
      $scope.user.name,
      $scope.user.password,
      $scope.user.passwordConfirmation,
      $scope.user.bio,
      $scope.user.subscribed,
      '/proposals');
  };

}]);

var OptionsController = glasatni.controller("OptionsController", ["$scope", "AuthService", "user", "messageService", function($scope, AuthService, user, messageService) {

  messageService.removeByLocation('register');

  $scope.AuthService = AuthService;
  $scope.user = angular.extend(user, { passwordConfirmation: "" });
  $scope.page = {
    showCurrentPassword: true,
    title: "Настройки",
    password: "Нова парола",
    button: "Промени!"
  };

  $scope.submit = function() {
    AuthService.updateUser(
      $scope.user.email,
      $scope.user.name,
      $scope.user.password,
      $scope.user.passwordConfirmation,
      $scope.user.bio,
      $scope.user.subscribed,
      $scope.user.currentPassword,
      '/proposals');
  };

}]);

OptionsController.loadUser = ["AuthService", function(AuthService) {

  return AuthService.userIsFetchedFromServer.then(function() {
    return AuthService.getUser();
  });

}];