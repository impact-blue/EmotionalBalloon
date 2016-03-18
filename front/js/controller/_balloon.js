app.controller('balloonController', function($scope, $http, querySortService, localStorageService) {
    $scope.data = balloon_data.data;
    $scope.path = location.pathname.split('/');
    $scope.query = querySortService;
    $scope.cart = localStorageService.load().cart;
});