promeni.factory('Comment', function($resource) {
  return $resource('/api/v1/comments/:id');
});

promeni.controller('CommentController', ['$scope', 'Comment', function($scope, Comment) {

  Comment.query(function(comments) {
    $scope.comments = comments;
  });

  $scope.vote = function(id, value) {

    var comment = $scope.comments.filter(function(c) { return c.id === id })[0];
  }

}]);

