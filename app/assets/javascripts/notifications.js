/**
 * Created by petko on 10/12/14.
 */

glasatni.controller("NotificationIndexController", ["$scope", "$http", function($scope, $http) {

  $http.get("/api/v1/notifications").then(function(res) {
    $scope.notifications = res.data;
  })

}]);