app.controller('balloonController', function($scope, $http, querySortService, getStorageService) {
    $scope.data = balloon_data.data;
    $scope.path = location.pathname.split('/');
    $scope.query = querySortService;
    $scope.cart = getStorageService.cart;
});