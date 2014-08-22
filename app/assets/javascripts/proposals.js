var ready = function() {

  var $sendButton = $("#send-button");
  var $commentBox = $("#comment-box");
  var $warning = $("#warning");
  var $symbolsBox = $("#symbolsBox");
  var $voteButtons = $(".vote-button");

  // render comments
  //$.ajax("/comments", function(comments) {
  //}).fail(function() {
  //});

  $commentBox.on("focus", function() {
    $warning.slideDown();
  });

  $sendButton.on("click", function() {
    var $btn = $(this);
    var $noComments = $("#no-comments");
    var content = $commentBox.val();
    var username = $("a#username").text();
    var proposal_id = window.location.pathname.match(/\d+$/)[0];
    var $commentsList = $("#comments-list");

    $btn.prop("disabled", true);

    // post a comment and resieve the html for the comment
    $.post("/comments", { comment: { content: content, proposal_id: proposal_id } }, function(commentHtml) {
      var $newComment;

      $commentBox.val("");
      $btn.prop("disabled", false);

      $noComments.hide();
      $commentsList.prepend(commentHtml);

      $newComment = $commentsList.children().first();

      // reinstantiate vote-buttons click fn
      $(".vote-button").on("click", voteButtonsClickFn);
      $('html, body').animate({ scrollTop: $newComment.offset().top }, 'slow');

    }).fail(function(msg) {

      // TODO custom message
      $("#whoops-box").modal("show");

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

  // this handles votings for comments
  var voteButtonsClickFn = function(res) {
    var $btn = $(res.currentTarget);
    var $otherBtn = $btn.siblings(".btn");
    var comment_id = $btn.attr("id").split("-")[0];
    var vote = $btn.attr("id").split("-")[1];
    var votable = $btn.attr("class").match("comment") === null ? "proposal" : "comment";

    $btn.prop("disabled", true);
    $otherBtn.prop("disabled", true);

    $.post("/vote", { vote: vote, id: comment_id, votable: votable }, function(res) {
      var $rating = $btn.parent().siblings("p");
      var cssClass = vote === "up" ? "btn-success" : "btn-danger";
      var otherCssClass = vote === "down" ? "btn-success" : "btn-danger";

      // change classes of button
      $btn.toggleClass("btn-default").toggleClass(cssClass);
      $otherBtn.removeClass(otherCssClass).addClass("btn-default");

      // change ratings
      $rating.text(res)

    }).fail(function() {

      // display 'something went wrong.'
      $("#whoops-box").modal("show");

    }).always(function() {

      // change btns back to enabled.
      $btn.prop("disabled", false);
      $otherBtn.prop("disabled", false);

    });

  };

  $voteButtons.on("click", voteButtonsClickFn);

  $voteButtons.tooltip();

};

$(document).ready(ready);
$(document).on("page:load", ready);
