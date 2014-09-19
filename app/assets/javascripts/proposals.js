promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag" }
  });
});

promeni.controller('ProposalController', ['$scope', 'Proposal', 'Theme', function($scope, Proposal, Theme) {
  $scope.order = "relevance";
  $scope.currentTheme = { id: "all", name: "Всички теми" };

  $scope.queryThemes = function() {
    Theme.query({}, function(themes) {
      $scope.themes = [$scope.currentTheme].concat(themes);
    });
  }

  $scope.queryProposals = function() {
    Proposal.query({ theme_id: $scope.currentTheme.id, order: $scope.order, page: $scope.currentPage }, function(proposals) {
      $scope.proposals = proposals;
    });
  }

  $scope.setCurrentTheme = function(theme) {
    $scope.currentTheme = theme;
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
  $scope.$watchCollection("[order, currentTheme, currentPage]", function(newValue, oldValue) {
    if(newValue === oldValue) return;
    $scope.queryProposals();
  });

}]);


