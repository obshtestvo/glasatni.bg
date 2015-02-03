glasatni.factory('Comment', ['$resource', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'query': {
      method: "GET",
      isArray: false,

      // transformResponse is needed to:
      // 1. attach 'reply' object on every comment in case the user wants to comment on it.
      // 2. convert the snake_case (API) to camelCase (the App)
      transformResponse: function(data) {
        data = JSON.parse(data);

        data.comments = data.comments.map(function(c) {
          return {
            id: c.id,
            content: c.content,
            timeAgo: c.time_ago,
            hotness: c.hotness,
            user: c.user,
            voted: c.voted,
            commentsCount: c.comments_count,
            comments: c.comments,
            reply: {
              content: "",
              showBox: false
            }
          }
        });

        return data;
      }
    },
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });
}]);

glasatni.controller('CommentController', ["$scope", "$routeParams", "Comment", "AuthService", "Modal", function($scope, $routeParams, Comment, AuthService, Modal) {

  var getCommentsData = function () {
    Comment.query($scope.params).$promise.then(function (data) {
      $scope.comments = data.comments;
      $scope.commentsCount = data.comments_count;
    });
  };

  $scope.params = {
    order: "oldest",
    page: 1,
    commentable_type: "proposal",
    commentable_id: $routeParams.id
  };

  $scope.$watchCollection("[params.order, params.page]", function(newValue, oldValue) {
    if (newValue === oldValue) return;
    getCommentsData();
  });

  $scope.destroyComment = function(comment) {
    Modal.open('destroyComment').then(function() {
      Comment.delete({ id: comment.id }).$promise.then(function() {
        getCommentsData();
      });
    });
  };

  AuthService.userIsFetchedFromServer.then(function() {

    if (AuthService.getUser()) {
      $scope.params.voter_id = AuthService.getUser().id;
    }
    getCommentsData();

  });

  $scope.showWarning = function() {
    $("#warning-box").slideDown();
    $("#comment-box").attr("rows", 8);
  };

  $scope.newComment = { content: "" };

  $scope.createNewComment = function(parentComment) {
    var params;

    if (typeof parentComment === "undefined") {
      params = {
        commentable_id: $scope.proposal.id,
        commentable_type: "proposal",
        content: $scope.newComment.content
      };
    } else {
      params = {
        commentable_id: parentComment.id,
        commentable_type: "comment",
        content: parentComment.reply.content
      };
    }

    Comment.save(params).$promise.then(function(comment) {

      // There is different business logic for top/nested comments
      // Top comment:
      if (params.commentable_type === "proposal") {
        $("#warning-box").slideUp();
        $("#comment-box").attr("rows", 3);
        $scope.newComment = { content: "" };

        // Our App is camelCase, our API is snake_case
        angular.extend(comment, { timeAgo: comment.time_ago });

        // Top comments are appended to the bottom as the 'new comment' box is at the bottom.
        // This way we do not need to scroll the page to the newly created comment.
        $scope.comments.push(comment);

      // nested comment:
      } else {

        // reset reply box
        $scope.cancelReply(parentComment);

        // Edge case: if the parent comment is just created and the user
        // replies to it's own comment without refreshing/changing the page or change
        // the sorting of the comments before that.
        if (typeof parentComment.comments === "undefined") { parentComment.comments = []; }

        // We will append the newly created comment to the top of the list, because
        // it is closer to the 'reply box'. This way we do not need to scroll the page
        // to the answer.
        parentComment.comments.unshift(comment);

      }

    }, function() { Modal.open('unknownError') });
  };

  $scope.cancelReply = function(comment) {
    comment.reply = {
      content: "",
      showBox: false
    };
  };

}]);

