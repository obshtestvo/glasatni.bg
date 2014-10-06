promeni.factory('Comment', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });
});

promeni.controller('CommentController', ['$scope', 'Comment', function($scope, Comment) {

  $scope.order = "relevance";

  $scope.params = {
    order: "relevance",
    page: 1,
    commentable_type: "proposal",
    commentable_id: window.location.pathname.match(/\d+$/)[0]
  }

  $scope.newComment = { content: "" };

  $scope.proposalId = window.location.pathname.match(/\d+$/)[0];

  // if filters change - fetch and assign result
  $scope.$watchCollection("[params.order, currentPage]", function(newValue, oldValue) {
    if (newValue === oldValue) return;
    $scope.queryComments({ commentable_id: $scope.proposalId, commentable_type: "proposal", order: $scope.order, page: $scope.currentPage });
  });

  $scope.queryComments = function() {
    Comment.query($scope.params, function(comments) {
      $scope.comments = comments;
    });
  }

  $scope.createNewComment = function() {
    Comment.save({ commentable_id: $scope.proposalId, commentable_type: "proposal", content: $scope.newComment.content }).$promise.then(function(newComment) {
      $scope.comments.unshift(newComment);
      $("#warning-box").slideUp();
      $scope.newComment = { content: "" };
    });
  }

  $scope.showWarning = function() {
    $("#warning-box").slideDown();
  }

  $scope.showNestedComments = function(comment) {
    Comment.query({ commentable_id: comment.id, commentable_type: "comment", order: "relevance" }, function(comments) {
      comment.comments = comments;
    })
  }

  $scope.replyToComment = function(comment) {
    Comment.save({ commentable_id: comment.id, commentable_type: "comment", content: comment.newComment }).$promise.then(function(newComment) {
      comment.comments.unshift(newComment);
      comment.newComment = "";
      comment.showReplyBox = false;
    });
  }

  $scope.cancelComment = function(comment) {
    comment.newComment = "";
    comment.showReplyBox = false;
  }

  // init
  $scope.queryComments();

}]);

promeni.directive('commentSection', function() {
  return {
    restrict: 'E',
    scope: {
      comment: "=",
    },
    templateUrl: "/assets/comment.html"
  }
});

promeni.directive('commentActions', ['Comment', function(Comment) {
  return {
    restrict: 'E',
    scope: {
      comment: "=",
    },
    link: function(scope) {

      scope.flag = function(reason) {
        Comment.flag({ id: scope.comment.id, reason: reason, flaggable: "comment" }).$promise.then(function(data) {
          scope.comment.alerts = [{
            type: "success", msg: "Вие докладвахте този коментар. Благодарим ви."
          }];
        });
      }

      scope.closeAlert = function() {
        scope.comment.alerts = [];
      }

      scope.destroyComment = function(idx) {
        scope.comment.$delete({ id: scope.comment.id }, function(data) {
          scope.$parent.$parent.comments.splice(idx, 1);
        });
      }
    },
    templateUrl: "/assets/comment_actions.html"
  }
}]);

