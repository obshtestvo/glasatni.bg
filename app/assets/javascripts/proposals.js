promeni.factory('Proposal', function($resource) {
  return $resource('/api/v1/proposals/:id');
});

promeni.controller('ProposalController', ['$scope', 'Proposal', function($scope, Proposal) {

  $scope.order = "relevance";

  $scope.$watch("order", function(newValue, oldValue) {
    Proposal.query({ order: $scope.order }, function(proposals) {
      $scope.proposals = proposals;
    });
  });

}]);

promeni.filter('translateOrder', function () {
  "use strict";
  return function (string) {
    var translations = {
      "newest": "Най-нови",
      "oldest": "Най-стари",
      "relevance": "Релевантност",
    }
    return translations[string];
  };
});
