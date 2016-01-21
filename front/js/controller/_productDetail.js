app.controller('productDetailController', function($scope, $http) {
    $http({
        method: 'GET',
        url: '/apis/products/detail.json'
    }).success(function(data, status, headers, config) {
        $scope.data = data.data;
    });
});