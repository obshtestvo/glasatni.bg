promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id');
});

promeni.controller('ProposalController', ['$scope', 'Proposal', function($scope, Proposal) {
  $scope.order = "relevance";

  // if filters change - fetch and assign result
  $scope.$watchCollection("[order, currentPage]", function(newValue, oldValue) {
    Proposal.query({ theme_id: $scope.themeId, order: $scope.order, page: $scope.currentPage }, function(proposals) {
      $scope.proposals = proposals;
    });
  });

}]);


