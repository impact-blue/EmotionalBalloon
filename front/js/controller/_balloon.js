app.controller('balloonController', function($scope, $http, querySortService, getStorageService) {
    $scope.data = balloon_data.data;
    $scope.query = querySortService;
    $scope.cart = getStorageService.cart;
});