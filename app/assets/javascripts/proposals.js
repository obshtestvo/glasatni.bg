promeni.controller('ProposalController', ['$scope', function($scope) {
  $scope.contacts = ["test test test", "more tests"];
}]);

$(document).on('ready page:load', function() {
  angular.bootstrap('body', ['promeni'])
})
