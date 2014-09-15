promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id');
});

promeni.controller('ProposalController', ['$scope', '$http', 'Proposal', function($scope, $http, Proposal) {
  $scope.order = "relevance";

  // get and assign total number of matching proposals
  $scope.$watch($scope.themeId, function() {
    $http({method: 'GET', url: '/api/v1/themes/' + $scope.themeId + '/proposals_count'})
    .success(function(data) {
      $scope.totalItems = data.count;
    });
  });

  // if filters change - fetch and assign result
  $scope.$watchCollection("[order, currentPage]", function(newValue, oldValue) {
    Proposal.query({ theme_id: $scope.themeId, order: $scope.order, page: $scope.currentPage }, function(proposals) {
      $scope.proposals = proposals;
    });
  });

}]);


