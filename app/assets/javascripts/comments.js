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

  $scope.newComment = { content: "" };

  $scope.showWarning = function() {
    $("#warning-box").slideDown();
  }

  $scope.showNestedComments = function(comment) {
    Comment.query({ commentable_id: comment.id, commentable_type: "comment", page: 1, order: "relevance" }, function(comments) {
      comment.comments = comments;
    })
  }

  $scope.destroyComment = function(comment, idx) {
    comment.$delete({ id: comment.id }, function(data) {
      $scope.comments.splice(idx, 1);
    });
  }

  $scope.replyToComment = function(comment, idx) {
    Comment.save({ commentable_id: comment.id, commentable_type: "comment", content: comment.newComment }).$promise.then(function(newComment) {
      console.log(newComment);
    });
  }

  $scope.flag = function(comment, reason) {
    Comment.flag({ id: comment.id, reason: reason, flaggable: "comment" }).$promise.then(function(data) {
      comment.alerts = [{
        type: "success", msg: "Вие докладвахте този коментар. Благодарим ви."
      }];
    });
  }

  $scope.closeAlert = function(comment) {
    comment.alerts = [];
  }

  // init
  $scope.queryComments();

}]);

