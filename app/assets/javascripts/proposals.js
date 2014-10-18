promeni.factory('Proposal', ["$resource", function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'update': { method: 'PUT' },
    'query': { method:'GET', isArray: false },
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag" }
  });
}]);

promeni.controller('ProposalController', ['$scope', '$http', '$routeParams', '$location', 'Proposal', 'action',
                   function($scope, $http, $routeParams, $location, Proposal, action) {

  // index

  $scope.queryProposals = function(params) {
    Proposal.query(params, function(data) {
      $scope.proposals = data.proposals;
      $scope.proposalsCount = data.proposals_count;
    });
  }

  $scope.pageChanged = function() {
    $scope.queryProposals({ theme_name: $scope.theme, order: $scope.order, page: $scope.currentPage });
    $location.search('page', $scope.currentPage);
  }

  // show

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

  // edit

  $scope.submitProposal = function(proposal) {

    var method;
    if (action == 'edit') {
      method = Proposal.update;
    } else {
      method == Proposal.save;
    }

    method({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme_id }).$promise.then(function(proposal) {
      $scope.proposal = proposal;
      $location.path("/proposals/" + proposal.id);
    });
  }

  if (action === "index") {

    $scope.theme = $routeParams.theme || "all";
    $scope.order = $routeParams.order || "relevance";
    $scope.currentPage = $routeParams.page || 1;
    $scope.queryProposals({ theme_name: $scope.theme, order: $scope.order, page: $scope.currentPage });

  } else if (action === "show" || action == "edit") {

    Proposal.get({ id: $routeParams.id }, function(proposal) {
      $scope.proposal = proposal;
    });

    $scope.logged_in = $("#logged_in").length !== 0 ? true : false;

  }

}]);


