promeni.factory('Theme', function($resource) {
  return $resource('/api/v1/themes/:id');
});
