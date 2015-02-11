glasatni.factory('Proposal', ["$resource", function($resource) {
  return $resource('/api/v1/proposals/:id', null, {
    'query': {
      method:'GET',
      isArray: false,
      // I need this tiny layer to switch form the snake_case API, to the camelCase used in js variables. (Sorry)
      transformResponse: function(data) {
        data = JSON.parse(data);

        data.proposals = data.proposals.map(function(p) {
          return {
            id: p.id,
            title: p.title,
            content: p.content,
            theme: p.theme,
            // the switch happens here:
            commentsCount: p.comments_count,
            user: p.user,
            approved: p.approved,
            voted: p.voted,
            hotness: p.hotness,
            up: p.up,
            down: p.down,
            // and here:
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

// this is a function returning promise that will be evaluated before every request for proposals listings.
ProposalIndexController.loadProposals = ["$rootScope", "$route", "AuthService", "Proposal", function($rootScope, $route, AuthService, Proposal) {

  // perhaps a ParamsService is needed
  $rootScope.params = {
    theme: ($route.current.params.theme || "all"),
    order: ($route.current.params.order || "newest"),
    page: ($route.current.params.page || 1)
  };

  // Only fetch proposals when we know whether or not the user is authorized on the server.
  // Otherwise a race condition is happening on page reload: the proposals can be fetched before we have information
  // about the user (All this is needed, because moderators and regulars have different proposal listings. ;_;)
  return AuthService.userIsFetchedFromServer.then(function() {

    // check if user is logged in and fetch id if so.
    if (AuthService.getUser()) {
      $rootScope.params.voter_id = AuthService.getUser().id;
    }

    // fetch proposals
    return Proposal.query($rootScope.params).$promise.then(function(data) {
      return data;
    });

  });

}];

glasatni.controller("ProposalShowController", ["$scope", "$rootScope", "$routeParams", "$location", "$anchorScroll", "$timeout", "AuthService", "Proposal", "Modal", function($scope, $rootScope, $routeParams, $location, $anchorScroll, $timeout, AuthService, Proposal, Modal) {
  var params = {
    id: $routeParams.id
  };
  if (AuthService.getUser()) {
    params.voter_id = AuthService.getUser().id;
  }

  $scope.AuthService = AuthService;

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

glasatni.controller("ProposalCreateController", ["$scope", "$location", "$http", "Proposal", "Modal", "AuthService", function($scope, $location, $http, Proposal, Modal, AuthService) {

  // only logged in users can create new proposals
  // otherwise -> redirect to /proposals
  if (!AuthService.getUser()) {
    var params = typeof $scope.$root.params === "undefined" ? { theme: "all", order: "newest" } : $scope.$root.params;
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
  };

}]);

