app.controller('cartShowController', function($scope, $http) {
    $scope.cartItem = cartItem;
    $scope.data = {};
    angular.forEach($scope.cartItem, function(value, key){
        $http({
            method: 'GET',
            url: '/api/products/detail.json'
        }).success(function(data, status, headers, config) {
            angular.merge($scope.data, data.data);
        });
    });
});