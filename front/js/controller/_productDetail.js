app.controller('productDetailController', function($scope, $http) {
    $scope.is_cart = false;
    $scope.cartItem = cartItem;
    $http({
        method: 'GET',
        url: '/api/products/detail.json'
    }).success(function(data, status, headers, config) {
        $scope.data = data.data;
        angular.forEach($scope.cartItem, function(value, key){
            if($scope.data.id === value) {
                $scope.is_cart = true;
            }
        });
    });

    $scope.toCart = function(id, flag) {
        var tmpItem = $scope.cartItem;
        $scope.cartItem = [];
        $scope.is_cart = !$scope.is_cart;
        angular.forEach(tmpItem, function(value, key){
            if(id !== value) {
                $scope.cartItem.push(value);
            }
        });
        if(flag) {
            $scope.cartItem.push(id);
        }
        localStorage.setItem("cart", JSON.stringify($scope.cartItem));
    };
});