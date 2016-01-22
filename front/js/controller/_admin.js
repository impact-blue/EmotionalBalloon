app.controller('adminController', function($scope, $http) {
    $scope.path = location.pathname;
    $scope.search = location.search;

    $http({
        method: 'GET',
        url: apiUrl[1]
    }).success(function(data, status, headers, config) {
        $scope.data = data.data;
    });
});