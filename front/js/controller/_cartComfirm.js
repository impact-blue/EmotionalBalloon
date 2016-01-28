app.controller('cartComfirmController', function($scope, $http) {
    $scope.test = {
        sample1: 'HelloWorld!!',
        sample2: 'hogehoge'
    };
    $scope.cartComfirm = function() {
        $http({
            method: 'POST',
            url: '/api/carts/comfirm',
            data: $scope.test
        }).success(function(data, status, headers, config) {
            console.log(data, status);
        }).error(function(data, status, headers, config) {
            consle.log(status);
        });
    };
});