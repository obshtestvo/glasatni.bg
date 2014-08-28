promeni.factory('Comment', function($resource) {
  return $resource('/api/v1/comments/:id', null, {
    'vote': { method: "POST", url: "/vote" }
  });
});

promeni.controller('CommentController', ['$scope', 'Comment', function($scope, Comment) {

  Comment.query(function(comments) {
    $scope.comments = comments;
  });

  $scope.proposal_id = window.location.pathname.match(/\d+$/)[0];

  $scope.vote = function(id, value) {
    var direction = value === 0 ? "up": "down";

    var comment = $scope.comments.filter(function(c) { return c.id === id })[0];

    Comment.vote({ id: id, vote: direction, votable: "comment" }).$promise.then(function(data) {

      comment.rating = data.rating;
      comment.voted = value;

    });;

  }

}]);

