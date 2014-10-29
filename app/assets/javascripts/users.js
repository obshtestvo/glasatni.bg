promeni.controller("UserController", ["$scope", "$routeParams", "$http", function($scope, $routeParams, $http) {

  $scope.proposals = [];
  $scope.comments = [];

  $http.get("/api/v1/users/" + $routeParams.id).success(function(user) {
    $scope.user = user;
  });

  $http.get("/api/v1/proposals?user_id=" + $routeParams.id).success(function(data) {
    $scope.proposals = data.proposals;
    $scope.proposalsCount = data.proposals_count;
  });

  $http.get("/api/v1/comments?user_id=" + $routeParams.id).success(function(data) {
    $scope.comments = data.comments;
    $scope.commentsCount = data.comments_count;
  });

}]);
