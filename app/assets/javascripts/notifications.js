glasatni.factory('Notification', ['$resource', function($resource) {
  return $resource('/api/v1/notifications/:id', null, {
    'query': { method:'GET', isArray: false }
  });
}]);

glasatni.controller("NotificationIndexController", ["$scope", "Notification", function($scope, Notification) {

  Notification.query({ page: 1 }).$promise.then(function(res) {
    $scope.notifications = res.notifications;
    $scope.page = res.page;
    $scope.notificationsCount = res.notifications_count;
  });

}]);