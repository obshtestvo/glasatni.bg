glasatni.controller("LoginController", ["$scope", "$http", function($scope, $http) {

  $scope.login = function(email, password, remember_me) {

    $http.post("/users/sign_in.json", {
      user: { email: email, password: password, remember_me: remember_me }
    }).then(function(res) {
      $scope.user = res.data;
    });

  };

}]);