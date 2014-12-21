glasatni.factory('Proposal', ["$resource", function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'query': {
      method:'GET',
      isArray: false,
      transformResponse: function(data) {
        data = JSON.parse(data);

        data.proposals = data.proposals.map(function(p) {
          return {
            id: p.id,
            title: p.title,
            content: p.content,
            theme: p.theme,
            commentsCount: p.comments_count,
            user: p.user,
            approved: p.approved,
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
    'flag': { method: "POST", url: "/flag" },
    'approve': { method: "POST", url: "/api/v1/proposals/:id/approve" }
  });
}]);

var ProposalIndexController = glasatni.controller("ProposalIndexController", ["$scope", "$routeParams", "$http", "$location", "data", "AuthService", function($scope, $routeParams, $http, $location, data, AuthService) {

  $scope.proposals = data.proposals;
  $scope.proposalsCount = data.proposals_count;

  $http.get("/api/v1/themes").success(function(themes) {
    $scope.selectedTheme = themes.filter(function(t) { return t.en_name === $scope.$root.params.theme })[0];
  });

  $scope.AuthService = AuthService;

  $scope.pageChanged = function() {
    $location.path("/proposals/theme/" + $scope.$root.params.theme + "/" + $scope.$root.params.order + "/" + $scope.$root.params.page);
  }

}]);

ProposalIndexController.loadProposals = ["$rootScope", "$route", "CurrentUser", "Proposal", function($rootScope, $route, CurrentUser, Proposal) {
  $rootScope.params = {
    theme: ($route.current.params.theme || "all"),
    order: ($route.current.params.order || "relevance"),
    page: ($route.current.params.page || 1)
  };

  if (CurrentUser.id) {
    $rootScope.params.voter_id = CurrentUser.id;
  }

  return Proposal.query($rootScope.params).$promise.then(function(data) {
    return data;
  });
}];

glasatni.controller("ProposalShowController", ["$scope", "$rootScope", "$routeParams", "$location", "$anchorScroll", "$timeout", "CurrentUser", "Proposal", "Modal", function($scope, $rootScope, $routeParams, $location, $anchorScroll, $timeout, CurrentUser, Proposal, Modal) {
  var params = {
    id: $routeParams.id
  };
  if (CurrentUser.id) {
    params.voter_id = CurrentUser.id;
  }

  $scope.currentUser = CurrentUser;

  Proposal.get(params).$promise.then(function(proposal) {
    $scope.proposal = proposal;
  }, function() {
    var fn = function() { $location.path("/proposals") };
    Modal.open('proposalNotFound').then(fn, fn);
  });

  $scope.destroyProposal = function(proposal) {
    Modal.open("destroyProposal").then(function() {
      Proposal.delete({ id: proposal.id }).$promise.then(function() {
        $location.path("/proposals/theme/" + proposal.theme.en_name + "/" + $rootScope.params.order);
      });
    });
  };

  $scope.approval = function(proposal, approved) {
    Proposal.approve({ id: proposal.id }, { approved: approved }).$promise.then(function(proposal) {
      $scope.proposal = proposal;
    }, function(response) {
      var reason = response.status === 403 ? "unauthorizedUpdateProposal" : "unknownError";
      Modal.open(reason);
    });
  };

  $anchorScroll();
}]);

glasatni.controller("ProposalEditController", ["$scope", "$routeParams", "$location", "$http", "Proposal", function($scope, $routeParams, $location, $http, Proposal) {

  $scope.proposal = Proposal.get({ id: $routeParams.id });
  $scope.showFormatting = false;
  $scope.title = "Редактирай предложението";
  $scope.icon = "fa-pencil";

  $http.get("/api/v1/themes").then(function(res) {
    $scope.themes = res.data;
  }, function() { Modal.open("unknownError") });

  $scope.submitProposal = function(proposal) {
    Proposal.update({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme.id }).$promise.then(function(proposal) {
      $location.path("/proposals/" + proposal.id);
    });
  }

}]);

glasatni.controller("ProposalCreateController", ["$scope", "$location", "$http", "Proposal", "Modal", "CurrentUser", function($scope, $location, $http, Proposal, Modal, CurrentUser) {

  if (!CurrentUser.id) {
    var params = typeof $scope.$root.params === "undefined" ? { theme: "all", order: "relevance" } : $scope.$root.params;
    var fn = function() { $location.path("/proposals/theme/" + params.theme + "/" + params.order) };
    Modal.open("unregisteredCreateProposal").then(fn, fn);
  }

  $http.get("/api/v1/themes").then(function(res) {
    $scope.themes = res.data;

    $scope.proposal = {
      title: "",
      content: "",
      theme: {
        id: $scope.themes[0].id
      }
    };
  }, function() { Modal.open("unknownError") });

  $scope.showFormatting = false;
  $scope.title = "Направи предложение";
  $scope.icon = "fa-plus-square";

  $scope.submitProposal = function(proposal) {
    var success = function(proposal) { $location.path("/proposals/" + proposal.id) };
    var failure = function() { Modal.open("unknownError") };

    Proposal.save({ id: proposal.id }, { title: proposal.title, content: proposal.content, theme_id: proposal.theme.id }).$promise.then(success, failure);
}

}]);

