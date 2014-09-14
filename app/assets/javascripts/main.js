// play nice with turbolinks
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
