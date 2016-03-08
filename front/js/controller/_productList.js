app.controller('productListController', function($scope, $http, querySortService) {
    $scope.formOptions = {
        category: balloon_data.data.category_list
    };
    $scope.formOptions.category.unshift({
        id: null,
        name_en: "all",
        name_jp: "すべて",
        type: ""
    });
    if(angular.isUndefined(querySortService.category)) {
        $scope.formModel = {
            category: null
        };
    } else {
        $scope.formModel = {
            category: Number(querySortService.category)
        };
    }
    $scope.findProduct = function(category) {
        if(category === null) {
            location.href = "/admin/products?status=" + querySortService['status'];
        } else {
            location.href = "/admin/products?status=" + querySortService['status'] + "&category=" + category;
        }
    };
});