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
            category: null
        };
    } else {
        $scope.product_data = balloon_data.data.detail_product;
    }

    $scope.formOptions = {
        category: balloon_data.data.category_list
    };

    $scope.uploadImage = function(file) {
        console.log(file);
        // $http({
        //     method: 'POST',
        //     url: '/api/image',
        //     data: file
        // }).success(function(data, status, headers, config) {
        //     console.log(data);
        // }).error(function(data, status, headers, config) {
        //     alert(status);
        // });
    };

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
                    location.href = "/admin/products?status=all";
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