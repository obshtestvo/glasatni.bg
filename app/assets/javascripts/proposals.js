promeni.factory('Proposal', ["$resource", function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'update': { method: 'PUT' },
    'query': { method:'GET', isArray: false },
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag" }
  });
}]);

promeni.service('proposalService', ["$routeParams", "Proposal", function($routeParams, Proposal) {

  this.get = function() {
    return Proposal.get({ id: $routeParams.id });
  };

  this.update = function(proposal) {
    return Proposal.update({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme_id });
  }

  this.save = function(proposal) {
    return Proposal.save({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme_id });
  }

  this.flag = function(proposal, reason) {
    return Proposal.flag({ id: proposal.id, reason: reason, flaggable: "proposal" });
  }

}]);

var ProposalIndexController = promeni.controller("ProposalIndexController", ["$scope", "$routeParams", "$location", "Proposal", "data", function($scope, $routeParams, $location, Proposal, data) {

  $scope.proposals = data.proposals;
  $scope.proposalsCount = data.proposals_count;

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

  $scope.theme = $routeParams.theme || "all";
  $scope.order = $routeParams.order || "relevance";
  $scope.currentPage = $routeParams.page || 1;

}]);

ProposalIndexController.loadProposals = ["$route", "Proposal", "Comment", function($route, Proposal, Comment) {
  return Proposal.query({ theme_name: $route.current.params.theme, order: $route.current.params.order }).$promise.then(function(data) {
    return data;
  });
}];

promeni.controller("ProposalShowController", ["$scope", "proposalService", "Proposal", "commentService", function($scope, proposalService, Proposal, commentService) {

  proposalService.get().$promise.then(function(proposal) {
    $scope.proposal = proposal;
  });

  $scope.flag = function(proposal, reason) {
    proposalService.flag(proposal, reason).$promise.then(function(data) {
      proposal.alerts = [{
        type: "success", msg: "Вие докладвахте този коментар. Благодарим ви."
      }];
    });
  }

  $scope.closeAlert = function(comment) {
    comment.alerts = [];
  }

}]);

promeni.controller("ProposalEditController", ["$scope", "$location", "proposalService", function($scope, $location, proposalService) {

  $scope.proposal = proposalService.get();
  $scope.showFormatting = false;
  $scope.title = "Редактирай предложението.";

  $scope.submitProposal = function(proposal) {
    proposalService.update(proposal).$promise.then(function(proposal) {
      $location.path("/proposals/" + proposal.id);
    });
  }

}]);

promeni.controller("ProposalCreateController", ["$scope", "$location", "proposalService", function($scope, $location, proposalService) {

  $scope.showFormatting = false;
  $scope.title = "Направи предложение";

  $scope.proposal = {
    title: "",
    conetnt: "",
    theme_id: 1
  }

  $scope.submitProposal = function(proposal) {
    proposalService.save(proposal).$promise.then(function(proposal) {
      $location.path("/proposals/" + proposal.id);
    });
  }

}]);

