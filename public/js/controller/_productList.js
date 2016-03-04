app.controller('productListController', function($scope, $http, querySortService) {
    $scope.formOptions = {
        category: balloon_data.data.category_list
    };
    $scope.formModel = {
        category: null
    };
    $scope.findProduct = function(category) {
        location.href = "/admin/products?status=" + querySortService['status'] + "&category=" + category;
    };
});