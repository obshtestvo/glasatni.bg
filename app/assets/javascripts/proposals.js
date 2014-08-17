var ready = function() {

  var $sendButton = $("#send-button");
  var $commentBox = $("#comment-box");
  var $commentList = $("#comment-list");
  var $warning = $("#warning");
  var $symbolsBox = $("#symbolsBox");
  var $voteButtons = $(".vote-button");

  $commentBox.on("focus", function() {
    $warning.slideDown();
  });

  $sendButton.on("click", function() {
    var $btn = $(this);
    var content = $commentBox.val();
    var username = $("a#username").text();
    var proposal_id = window.location.pathname.match(/\d+$/)[0];

    $btn.prop("disabled", true);

    // post a comment and resieve the html for the comment
    $.post("/comments", { comment: { content: content, proposal_id: proposal_id } }, function(comment_msg) {
      $commentBox.val("");
      $btn.prop("disabled", false);

      //FIXME
      //$commentList.prepend("<li>0 | " + username + " | " + content + "</li>");

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

  // this handles votings for comments (and proposals??)

  $voteButtons.on("click", function() {
    var $btn = $(this);
    var $otherBtn = $btn.siblings(".btn");
    var comment_id = $btn.attr("id").split("-")[0];
    var vote = $btn.attr("id").split("-")[1];

    $btn.prop("disabled", true);
    $otherBtn.prop("disabled", true);

    $.post("/comments/vote", { comment: { vote: vote, id: comment_id } }, function(res) {
      var $rating = $btn.parent().siblings("p");
      var cssClass = vote === "up" ? "btn-success" : "btn-danger";
      var otherCssClass = vote === "down" ? "btn-success" : "btn-danger";

      // change classes of button
      $btn.toggleClass("btn-default").toggleClass(cssClass);
      $otherBtn.removeClass(otherCssClass).addClass("btn-default");

      // change ratings
      $rating.text(res)

    }).fail(function(res) {

      // display 'something went wrong.'
      $("#whoops-box").modal("show")

    }).always(function(res) {

      // change btns back to enabled.
      $btn.prop("disabled", false);
      $otherBtn.prop("disabled", false);

    });

  });

  $voteButtons.tooltip();

};

$(document).ready(ready);
$(document).on("page:load", ready);
