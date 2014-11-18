promeni.factory('Comment', ['$resource', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'query': { method:'GET', isArray: false },
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });
}]);

promeni.controller('CommentController', ["$scope", "$routeParams", "Comment", "CurrentUser", "Modal", function($scope, $routeParams, Comment, CurrentUser, Modal) {

  var getCommentsData = function() {
    Comment.query($scope.params).$promise.then(function(data) {
      $scope.comments = data.comments;
      $scope.commentsCount = data.comments_count;
    });
  }

  $scope.params = {
    order: "relevance",
    page: 1,
    commentable_type: "proposal",
    commentable_id: $routeParams.id
  }

  if (CurrentUser.id) {
    $scope.params.voter_id = CurrentUser.id;
  }

  $scope.$watchCollection("[params.order, params.page]", function(newValue, oldValue) {
    if (newValue === oldValue) return;
    getCommentsData();
  });

  $scope.destroyComment = function(comment) {
    Modal.open('destroyComment').then(function() {
      Comment.delete({ id: comment.id }).$promise.then(function(data) {
        getCommentsData();
      });
    });
  }

  getCommentsData();

  $scope.showWarning = function() {
    $("#warning-box").slideDown();
    $("#comment-box").attr("rows", 8);
  }

  $scope.newComment = { content: "" };

  $scope.createNewComment = function() {
    var params = {
      commentable_id: $scope.proposal.id,
      commentable_type: "proposal",
      content: $scope.newComment.content
    };
    Comment.save(params).$promise.then(function(comment) {
      $("#warning-box").slideUp();
      $("#comment-box").attr("rows", 3);
      $scope.newComment = { content: "" };
      $scope.comments.unshift(comment);

    }, function() { Modal.open('unknownError') });
  }

}]);

