app.controller('productShowController', function($scope, $http, localStorageService) {
    var storage = localStorageService.load();
    $scope.saveFlag = true;
    if(angular.isDefined(storage.cart)) {
        angular.forEach(storage.cart, function(value, key) {
            if(balloon_data.data.detail_product.id === value) {
                $scope.saveFlag = false;
            }
        });
    }

    $scope.saveProduct = function(id) {
        storage = localStorageService.load();
        if($scope.saveFlag) {
            localStorageService.save(storage.cart, id);
            $scope.saveFlag = false;
        } else {
            localStorageService.delete(storage.cart, id);
            $scope.saveFlag = true;
        }
    };
});