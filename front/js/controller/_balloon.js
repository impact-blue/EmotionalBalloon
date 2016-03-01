app.controller('balloonController', function($scope, $http, querySortService) {
    $scope.data = balloon_data.data;
    $scope.query = querySortService;
});