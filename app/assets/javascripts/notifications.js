glasatni.controller("NotificationIndexController", ["$scope", "$http", function($scope, $http) {

  $http.get("/api/v1/notifications").then(function(res) {
    $scope.notifications = res.data.notifications;
    $scope.page = res.data.page;
    $scope.notificationsCount = res.data.notifications_count;
  });

}]);