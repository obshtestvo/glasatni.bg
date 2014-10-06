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
      "most-comments": "Коментирани",
      "least-comments": "Некоментирани",
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
    link: function (scope) {

      scope.vote = function(value) {
        var direction = value === 0 ? "up": "down";
        var params = { id: scope.votable.id, vote: direction, votable: scope.votableType };
        var success = function(response) {
          scope.votable.hotness = response.hotness;
          scope.votable.voted = scope.votable.voted === value ? -1 : value;
        }
        var failure = function(response) {
          if (response.statusText == "Unauthorized") {
            scope.$root.$modalMessages = {
              title: "Чакай малко!",
              body: "Само регистрирани потребители могат да гласуват.",
              button: "Ясно, разбрах."
            }
          } else {
            scope.$root.$modalMessages = {
              title: "Опа!",
              body: "Изглежда, че гласуването не работи по някаква причина. Моля да ни извините!",
              button: "От мен да мине."
            }
          }
          angular.element("#whoops-box").modal();
        }

        if (scope.votableType === "proposal") {
          Proposal.vote(params, success, failure);
        }else {
          Comment.vote(params, success, failure);
        }
      }

    },
    templateUrl: '/assets/buttons.html'
  };
}]);

