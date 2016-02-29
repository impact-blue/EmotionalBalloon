app.controller('categoryEditController', function($scope, $http) {
    if(location.pathname.split('/')[4] !== 'new') {
        $scope.categoryContent = {
            id: balloon_data.data.category_detail.id,
            type: balloon_data.data.category_detail.type,
            name_en: balloon_data.data.category_detail.name_en,
            name_jp: balloon_data.data.category_detail.name_jp
        };
    } else {
        $scope.categoryContent = {
            id: null,
            type: null,
            name_en: null,
            name_jp: null
        };
    }


    $scope.editCategory = function(key) {
        var sendData = {
            data: $scope.categoryContent
        };
        if(key === 'scene') {
            $http({
                method: 'PATCH',
                url: '/api/categories/scenes',
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
        } else {
            $http({
                method: 'PATCH',
                url: '/api/categories/characters',
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
        }
    };
});