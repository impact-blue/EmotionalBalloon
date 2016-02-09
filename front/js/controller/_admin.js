app.controller('adminController', function($scope, $http) {
    $scope.path = location.pathname;
    $scope.search = location.search;
    $scope.data = balloon_data.data;
    console.log($scope.search);
});