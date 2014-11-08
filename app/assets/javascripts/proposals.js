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
            voted: p.voted
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
    $location.path("/" + $scope.theme + "/" + $scope.order + "/" + $scope.currentPage);
  }

  $scope.theme = $routeParams.theme || "all";
  $scope.order = $routeParams.order || "relevance";
  $scope.currentPage = $routeParams.page || 1;

}]);

ProposalIndexController.loadProposals = ["$route", "Proposal", function($route, Proposal) {
  var params = {
    theme_name: $route.current.params.theme,
    order: $route.current.params.order,
    page: $route.current.params.page
  };
  return Proposal.query(params).$promise.then(function(data) {
    return data;
  });
}];

promeni.controller("ProposalShowController", ["$scope", "$routeParams", "$location", "Proposal", function($scope, $routeParams, $location, Proposal) {

  Proposal.get({ id: $routeParams.id }).$promise.then(function(proposal) {
    $scope.proposal = proposal;
  });

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

  $scope.delete = function(proposal) {
    Proposal.delete({ id: proposal.id }).$promise.then(function(data) {
      $location.path("/themes/" + proposal.theme.id);
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

promeni.controller("ProposalCreateController", ["$scope", "$location", "Proposal", function($scope, $location, Proposal) {

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
    var success = function(proposal) {
      $location.path("/proposals/" + proposal.id);
    }

    var failure = function(errors) {
      // TODO bring up modal or smth.
    }

    Proposal.save({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme.id }).$promise.then(success, failure);
  }

}]);

