promeni.factory('Comment', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });
});

promeni.controller('CommentController', ['$scope', 'Comment', function($scope, Comment) {

  $scope.order = "relevance";

  $scope.proposalId = window.location.pathname.match(/\d+$/)[0];

  // if filters change - fetch and assign result
  $scope.$watchCollection("[order, currentPage]", function(newValue, oldValue) {
    Comment.query({ proposal_id: $scope.proposalId, order: $scope.order, page: $scope.currentPage }, function(comments) {
      $scope.comments = comments;
    });
  });

  $scope.vote = function(comment, value) {
    var direction = value === 0 ? "up": "down";

    Comment.vote({ id: comment.id, vote: direction, votable: "comment" }).$promise.then(function(data) {
      comment.rating = data.rating;
      comment.voted = comment.voted === value ? -1 : value;
    });;
  }

  $scope.createNewComment = function() {
    Comment.save({ proposal_id: $scope.proposalId, content: $scope.newComment.content }).$promise.then(function(newComment) {
      $scope.comments.unshift(newComment);
      $("#warning-box").slideUp();
      $("#comment-box").val("");
    });
  }

  $scope.newComment = { content: "" };

  $scope.showWarning = function() {
    $("#warning-box").slideDown();
  }

  $scope.destroyComment = function(comment, idx) {
    comment.$delete({ id: comment.id }, function(data) {
      $scope.comments.splice(idx, 1);
    });
  }

  $scope.flag = function(comment, reason) {
    Comment.flag({ id: comment.id, reason: reason, flaggable: "comment" }).$promise.then(function(data) {
      comment.alerts = [{
        type: "success", msg: "Вие докладвахте този коментар."
      }];
    });
  }

  $scope.closeAlert = function(comment, idx) {
    comment.alerts = [];
  }

}]);

