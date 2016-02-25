app.controller('categoryEditController', function($scope, $http) {
    $scope.categoryContent = {
        id: balloon_data.data.category_detail.id,
        type: balloon_data.data.category_detail.type,
        name_en: balloon_data.data.category_detail.name_en,
        name_jp: balloon_data.data.category_detail.name_jp
    };

    $scope.editCategory = function() {
        var sendData = {
            data: $scope.categoryContent
        };
        $http({
            method: 'PATCH',
            url: '/api/categories/edit',
            data: sendData
        }).success(function(data, status, headers, config) {
            if(data.data.result === 'success') {
                location.href = "/admin/categories";
            } else {
                alert(data.data.message);
            }
        }).error(function(data, status, headers, config) {
            alert(status);
        });
    };
});