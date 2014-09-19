// make angular work nice with turbolinks
$(document).on('ready page:load', function() {
  angular.bootstrap('body', ['promeni'])
})

var promeni = angular.module('promeni', ['ngResource', 'ui.bootstrap']);

promeni.filter('translateOrder', function () {
  "use strict";
  return function (string) {
    var translations = {
      "newest": "Най-нови",
      "oldest": "Най-стари",
      "relevance": "Релевантност",
      "most-comments": "Най-коментирани",
      "least-comments": "Най-некоментирани",
    }
    return translations[string];
  };
});

promeni.directive('votingButtons', ['Proposal', 'Comment', function(Proposal, Comment) {
  return {
    restrict: 'E',
    scope: {
      votable: "=",
      votableType: "="
    },
    link: function (scope, element) {

      scope.vote = function(votable, value) {
        var direction = value === 0 ? "up": "down";
        var params = { id: votable.id, vote: direction, votable: scope.votableType };
        var cb = function(data) {
          votable.hotness = data.hotness;
          votable.voted = votable.voted === value ? -1 : value;
        }

        if (scope.votableType === "proposal") {
          Proposal.vote(params, cb)
        }else {
          Comment.vote(params, cb)
        }
      }

    },
    templateUrl: '/assets/buttons.html'
  };
}]);
