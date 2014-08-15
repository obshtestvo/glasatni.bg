var ready = function() {

  var $sendButton = $("#send-button");
  var $commentBox = $("#comment-box");
  var $commentList = $("#comment-list");
  var $warning = $("#warning");
  var $symbolsBox = $("#symbolsBox");
  var proposal_id = window.location.pathname.match(/\d+$/)[0];

  $commentBox.on("focus", function() {
    $warning.slideDown();
  });

  $sendButton.on("click", function() {
    var content = $commentBox.val();
    var username = $("a#username").text();

    $.post("/comments", { comment: { content: content, proposal_id: proposal_id } }, function(msg) {
      $commentBox.val("");

      $commentList.prepend("<li>0 | " + username + " | " + content + "</li>");

    });
  });

  $commentBox.keyup(function() {
    var count = $(this).val().length;

    if (count > 100) {
      $sendButton.prop("disabled", false);
      $symbolsBox.hide();
    } else {
      $sendButton.prop("disabled", true);
      $symbolsBox.show();
      $symbolsBox.text("Остават ти " + (100 - count) + " символа");
    }

  });

};

$(document).ready(ready);
$(document).on("page:load", ready);
