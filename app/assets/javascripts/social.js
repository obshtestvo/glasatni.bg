glasatni.directive('fbSocialBox', ["$window", function($window) {
  return {
    restrict: "E",
    scope: {},
    template: '<div class="fb-like-box" data-href="https://www.facebook.com/glasatni" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>',
    link: function(scope, element, attrs) {

      var fbEnsureInit = function(callback) {
        if(!window.fbApiInit) {
          setTimeout(function() {
            fbEnsureInit(callback);
          }, 50);
        } else {
          if(callback) {
            callback();
          }
        }
      };

      $window.FB.XFBML.parse(element[0]);
    }
  }
}]);