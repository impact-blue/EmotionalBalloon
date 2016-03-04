app.controller('productCreateController', function($scope, $http) {
    if(location.pathname.split('/')[3] === 'new') {
        $scope.product_data = {
            id: null,
            name: '',
            price: null,
            stock: null,
            images: [],
            description: '',
            size: '',
            status: '',
            category: {}
        };
        $scope.formModel = {
            category: 'scene'
        };
    } else {
        $scope.product_data = balloon_data.data.detail_product;
        $scope.formModel = {
            category: balloon_data.data.detail_product.category.type
        };
        $scope.product_data.category = balloon_data.data.detail_product.category;
    }

    console.log('hii');

    $scope.formOptions = {
        category: []
    };

    $scope.$watch('formModel.category', function(value) {
        $scope.formOptions.category = [];
        if(value === 'scene') {
            angular.forEach(balloon_data.data.category_list.scene, function(value, key) {
                $scope.formOptions.category.push(value);
            });
            $scope.product_data.category.name_en = 'marriage';
        } else if(value === 'character') {
            angular.forEach(balloon_data.data.category_list.character, function(value, key) {
                $scope.formOptions.category.push(value);
            });
            $scope.product_data.category.name_en = 'disney';
        }
    });

    $scope.editProduct = function() {
        var sendData = {
            data: $scope.product_data
        };
        console.log(sendData);
        if(location.pathname === '/admin/products/new') {
            $http({
                method: 'POST',
                url: '/api/products/edit',
                data: sendData
            }).success(function(data, status, headers, config) {
                if(data.data.result === 'success') {
                    location.href = "/admin/products";
                } else {
                    alert(data.data.message);
                }
            }).error(function(data, status, headers, config) {
                alert(status);
            });
        } else {
            $http({
                method: 'PATCH',
                url: '/api/products/edit',
                data: sendData
            }).success(function(data, status, headers, config) {
                if(data.data.result === 'success') {
                    location.href = "/admin/products";
                } else {
                    alert(data.data.message);
                }
            }).error(function(data, status, headers, config) {
                alert(status);
            });
        }
    };
});