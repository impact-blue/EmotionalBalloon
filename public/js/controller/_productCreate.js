app.controller('productCreateController', function($scope, $http, Upload) {
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
            category: null
        };
    } else {
        $scope.product_data = balloon_data.data.detail_product;
    }

    $scope.formOptions = {
        category: balloon_data.data.category_list
    };

    $scope.formModel = {
        images: []
    };

    $scope.uploadImage = function(content) {
        angular.forEach(content, function(value, key){
            $scope.product_data.images.push(value);
        });
    };

    $scope.editProduct = function() {
        var sendData = {
            data: $scope.product_data
        };
        console.log(sendData);
        if(location.pathname === '/admin/products/new') {
            Upload.upload({
                method: 'POST',
                url: '/api/products/edit',
                file: sendData.data.images,
                data: sendData
            }).success(function(data, status, headers, config) {
                if(data.data.result === 'success') {
                    location.href = "/admin/products?status=all";
                } else {
                    alert(data.data.message);
                }
            }).error(function(data, status, headers, config) {
                alert(status);
            });
        } else {
            Upload.upload({
                method: 'PATCH',
                url: '/api/products/edit',
                file: sendData.data.images,
                data: sendData
            }).success(function(data, status, headers, config) {
                if(data.data.result === 'success') {
                    location.href = "/admin/products?status=all";
                } else {
                    alert(data.data.message);
                }
            }).error(function(data, status, headers, config) {
                alert(status);
            });
        }
    };
});