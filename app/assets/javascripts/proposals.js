promeni.factory('Proposal', ["$resource", function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'query': {
      method:'GET',
      isArray: false,
      transformResponse: function(data) {
        data = JSON.parse(data);

        data.proposals = data.proposals.map(function(p) {
          return {
            id: p.id,
            user: p.user,
            title: p.title,
            content: p.content,
            theme: p.theme,
            commentsCount: p.comments_count,
            user: p.user,
            voted: p.voted,
            hotness: p.hotness,
            timeAgo: p.time_ago
          }
        });

        return data;
      }
    },
    'vote': { method: "POST", url: "/vote" },
    'update': { method: 'PUT' },
    'flag': { method: "POST", url: "/flag" }
  });
}]);

var ProposalIndexController = promeni.controller("ProposalIndexController", ["$scope", "$routeParams", "$location", "data", function($scope, $routeParams, $location, data) {

  $scope.proposals = data.proposals;
  $scope.proposalsCount = data.proposals_count;

  $scope.pageChanged = function() {
    $location.path("/" + $scope.$root.params.theme + "/" + $scope.$root.params.order + "/" + $scope.$root.params.page);
  }

}]);

ProposalIndexController.loadProposals = ["$rootScope", "$route", "CurrentUser", "Proposal", function($rootScope, $route, CurrentUser, Proposal) {
  $rootScope.params = {
    theme: ($route.current.params.theme || "all"),
    order: ($route.current.params.order || "relevance"),
    page: ($route.current.params.page || 1),
  }

  if (CurrentUser.id) {
    $rootScope.params.voter_id = CurrentUser.id;
  }

  return Proposal.query($rootScope.params).$promise.then(function(data) {
    return data;
  });
}];

promeni.controller("ProposalShowController", ["$scope", "$rootScope", "$routeParams", "$location", "CurrentUser", "Proposal", "Modal", function($scope, $rootScope, $routeParams, $location, CurrentUser, Proposal, Modal) {
  var params = {
    id: $routeParams.id
  };
  params.voter_id = CurrentUser.id;

  $scope.currentUser = CurrentUser;

  Proposal.get(params).$promise.then(function(proposal) {
    $scope.proposal = proposal;
  });

  $scope.destroyProposal = function(proposal) {
    Modal.open("destroyProposal").then(function() {
      Proposal.delete({ id: proposal.id }).$promise.then(function(data) {
        $location.path("/proposals/theme/" + proposal.theme.en_name + "/" + $rootScope.params.order);
      });
    });
  }

}]);

promeni.controller("ProposalEditController", ["$scope", "$routeParams", "$location", "Proposal", function($scope, $routeParams, $location, Proposal) {

  $scope.proposal = Proposal.get({ id: $routeParams.id });
  $scope.showFormatting = false;
  $scope.title = "Редактирай предложението";
  $scope.icon = "fa-pencil";

  $scope.submitProposal = function(proposal) {
    Proposal.update({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme.id }).$promise.then(function(proposal) {
      $location.path("/proposals/" + proposal.id);
    });
  }

}]);

promeni.controller("ProposalCreateController", ["$scope", "$location", "Proposal", "Modal", function($scope, $location, Proposal, Modal) {

  $scope.showFormatting = false;
  $scope.title = "Направи предложение";
  $scope.icon = "fa-plus-square";

  $scope.proposal = {
    title: "",
    conetnt: "",
    theme: {
      id: $("select option").get(0).value,
    }
  }

  $scope.submitProposal = function(proposal) {
    var success = function(proposal) { $location.path("/proposals/" + proposal.id) };
    var failure = function() { Modal.open("unknownError") };

    Proposal.save({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme.id }).$promise.then(success, failure);
  }

}]);

