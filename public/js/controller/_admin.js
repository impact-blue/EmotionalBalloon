app.controller('adminController', function($scope, $http) {
    $scope.path = location.pathname;
    $scope.split = $scope.path.split('/');
    $scope.search = location.search;
    $scope.data = balloon_data.data;

    $scope.checkCSV = [];
    $scope.tmpCSV = '';
    $scope.$watch('checkCSV', function(value) {
        $scope.tmpCSV = '';
        angular.forEach($scope.checkCSV, function(val, index) {
            if(val) {
                $scope.tmpCSV = $scope.tmpCSV + '+' + balloon_data.data.search_products.product_list[index].id;
            }
        });
        $scope.tmpCSV = $scope.tmpCSV.substr(1);
    }, true);
    $scope.exportCSV = function() {
        if($scope.tmpCSV.length) {
            location.href = '/admin/products.csv?id=' + $scope.tmpCSV;
        } else {
            location.href = '/admin/products.csv' + $scope.search;
        }
    };
});