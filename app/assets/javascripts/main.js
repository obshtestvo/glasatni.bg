var promeni = angular.module('promeni', ['ngResource']);

// play nice with turbolinks
$(document).on('ready page:load', function() {
  angular.bootstrap('body', ['promeni'])
})
