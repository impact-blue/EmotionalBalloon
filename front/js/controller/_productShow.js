app.controller('productShowController', function($scope, $http, getStorageService, saveStorageService) {
    $scope.saveProduct = function(id) {
        var saveFlag = true;
        angular.forEach(getStorageService.cart, function(value, key) {
            if(id === value) {
                saveFlag = false;
            }
        });
        if(saveFlag) {
            saveStorageServie('hi');
        }
    };
});