glasatni.directive('fbSocialBox', ["$window", function($window) {
  return {
    restrict: "E",
    scope: {},
    template: '<div class="fb-like-box" data-href="https://www.facebook.com/glasatni" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>',
    link: function(scope, element, attrs) {

      var ensureRender = function(callback) {
        if(typeof $window.FB === "undefined") {
          setTimeout(function() {
            ensureRender(callback);
          }, 50);
        } else {
          $window.FB.XFBML.parse(element[0]);
        }
      };

      ensureRender();

    }
  }
}]);