promeni.factory('Comment', ['$resource', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'query': { method:'GET', isArray: false },
    'vote': { method: "POST", url: "/vote" },
    'flag': { method: "POST", url: "/flag"}
  });
}]);

promeni.controller('CommentCreateController', ["$scope", "Comment", function($scope, Comment) {

  $scope.logged_in = $("#logged_in").length !== 0 ? true : false;

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
    });
  }

}]);

promeni.controller('CommentIndexController', ["$scope", "$routeParams", "Comment", "Modal", function($scope, $routeParams, Comment, Modal) {
  var getCommentsData = function() {
    Comment.query($scope.params).$promise.then(function(data) {
      $scope.comments = data.comments;
      $scope.commentsCount = data.comments_count;
    });
  }
  var $el = $("#username");

  $scope.params = {
    order: "relevance",
    page: 1,
    commentable_type: "proposal",
    commentable_id: $routeParams.id
  }

  if ($el.length !== 0) {
    $scope.params.voter_id = $el.attr("href").match(/\d+/)[0];
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

}]);


