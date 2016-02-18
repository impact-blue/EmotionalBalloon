app.controller('productCreateController', function($scope, $http) {
    $scope.product_data = {
        id: null,
        name: null,
        price: null,
        stock: null,
        images: [
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720172",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720173",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720174",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720175"
        ],
        description: null,
        size: null,
        status: null,
        scenes: [],
        characters: []
    };
    $scope.editProduct = function() {
        var sendData = {
            data: $scope.product_data
        }
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