// [14.09.2014] This whole thing is needed so Facebook's SDK can work smoothly
// with turbolinks... ಠ_ಠ

var $fbRoot = null; // variable use to transfer the state of the fb-root div tag between page requests
var fbEventsBound = false;

var saveFBRoot = function() {
  $fbRoot = $('#fb-root').detach();
}

var restroreFBRoot = function() {
  if ($("#fb-root").length > 0) {
    $("#fb-root").replaceWith($fbRoot);
  } else {
    $("body").append($fbRoot);
  }
}

var loadFBSDK = function() {
  window.fbAsyncInit = function() {
    FB.init({
      appId      : 1487893938139352,
      xfbml      : true,
      version    : 'v2.1'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/all.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
}

var bindFBEvents = function() {
  $(document).on('ready page:fetch', function() {
    saveFBRoot();
  });

  $(document).on('ready page:change', function() {
    restroreFBRoot();
  });

  $(document).on('ready page:load', function() {
    if (typeof FB !== 'undefined') {
      FB.XFBML.parse();
    }
  });
  fbEventsBound = true;
}

var init = function() {
  loadFBSDK();
  if (!fbEventsBound) {
    bindFBEvents();
  }
}

init();