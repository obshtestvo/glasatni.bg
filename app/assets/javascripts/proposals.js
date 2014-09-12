promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id');
});

promeni.controller('ProposalController', ['$scope', 'Proposal', function($scope, Proposal) {

  $scope.order = "relevance";

  $scope.$watch("order", function(newValue, oldValue) {
    Proposal.query({ order: $scope.order }, function(proposals) {
      $scope.proposals = proposals;
    });
  });

}]);


