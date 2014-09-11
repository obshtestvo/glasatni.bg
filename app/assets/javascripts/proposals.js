promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id');
});

promeni.controller('ProposalController', ['$scope', 'Proposal', function($scope, Proposal) {

  Proposal.query(function(proposals) {
    $scope.proposals = proposals;
  });

}]);


