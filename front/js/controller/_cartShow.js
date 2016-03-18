app.controller('cartShowController', function($scope, $http, localStorageService) {
    $scope.cartItem = [];
    $scope.sumPrice = 0;
    angular.forEach(localStorageService.load().cart, function(value, key){
        $http({
            method: 'GET',
            url: '/api/products/detail.json?id=' + value
        }).success(function(data, status, headers, config) {
            if(data.result === 'success') {
                $scope.cartItem.push(data.data.product_detail);
            } else {
                console.log(data.message);
            }
            $scope.sumPrice += data.data.product_detail.price;
        }).error(function(data, status, headers, config) {
            alert(status);
        });
    });
});