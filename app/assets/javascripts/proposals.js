promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag" }
  });
});

promeni.controller('ProposalController', ['$scope', '$http', '$routeParams', 'Proposal', function($scope, $http, $routeParams, Proposal) {
  $scope.theme = $routeParams.theme || "all";
  $scope.order = $routeParams.order || "relevance";
  $scope.page = $routeParams.page || 1;

  $scope.queryThemes = function() {
    Theme.query({}, function(themes) {
      $scope.themes = [$scope.currentTheme].concat(themes);
    });
  }

  $scope.queryProposals = function() {
    Proposal.query({ theme_id: $scope.currentTheme.id, order: $scope.order, page: $scope.currentPage }, function(proposals) {
      $scope.proposals = proposals;
    });
    $http({ url: "/api/v1/proposals/count", params: { theme_id: $scope.theme }}).success(function(count) {
      $scope.proposalsCount = count;
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
  $scope.$watchCollection("[order, theme, currentPage]", function(newValue, oldValue) {
    if(newValue === oldValue) return;
    $scope.queryProposals();
  });

}]);


