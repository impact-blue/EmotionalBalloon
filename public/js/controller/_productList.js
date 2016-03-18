app.controller('productListController', function($scope, $http, querySortService) {
    $scope.formOptions = {
        category: balloon_data.data.category_list,
        per_page: [
            20,
            50,
            100
        ]
    };
    $scope.formOptions.category.unshift({
        id: 0,
        name_en: "all",
        name_jp: "すべて",
        type: ""
    });
    $scope.formModel = {
        category: Number(querySortService.category),
        per_page: Number(querySortService.per_page)
    };
    $scope.$watch('formModel', function(value) {
        console.log(value.category, querySortService.category);
        if(value.category !== Number(querySortService.category) || value.per_page !== Number(querySortService.per_page)) {
            location.href = "/admin/products?status=" + querySortService['status'] + "&category=" + value.category + "&per_page=" + value.per_page;
        }
    }, true);
});