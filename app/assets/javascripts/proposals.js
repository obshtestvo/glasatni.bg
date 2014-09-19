promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });

});

promeni.controller('ProposalController', ['$scope', 'Proposal', function($scope, Proposal) {
  $scope.order = "relevance";

  $scope.queryProposals = function() {
    Proposal.query({ theme_id: $scope.themeId, order: $scope.order, page: $scope.currentPage }, function(proposals) {
      $scope.proposals = proposals;
    });
  }

  $scope.getProposal = function() {
    var proposalId = window.location.pathname.match(/\d+$/)[0];
    Proposal.get({ id: proposalId }, function(proposal) {
      $scope.proposal = proposal;
    });
  }

  $scope.flag = function(proposal, reason) {
    Proposal.flag({ id: proposal.id, reason: reason, flaggable: "proposal" }).$promise.then(function(data) {
      proposal.alerts = [{
        type: "success", msg: "Вие докладвахте този коментар. Благодарим ви."
      }];
    });
  }

  $scope.closeAlert = function(comment) {
    comment.alerts = [];
  }

  // if filters change - fetch and assign result
  $scope.$watchCollection("[order, currentPage]", function(newValue, oldValue) {
    if(newValue === oldValue) return;
    $scope.queryProposals();
  });

}]);


