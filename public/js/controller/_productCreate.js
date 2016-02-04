app.controller('productCreateController', function($scope, $http) {
    $scope.product_data = {
        data: {
            name: "テスト",
            price: 2000,
            stock: 10,
            images: [
                "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720172",
                "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720173",
                "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720174",
                "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720175"
            ],
            description: "当店人気ナンバーワンのバルーン電報です。淡いピンクが輝いて、キレイな祝電です。ウェルカムボードの横に置いたり、高砂席の両サイドに飾ってもステキですよ。",
            keywords: [
                'キーワード1',
                'キーワード2',
                'キーワード3',
                'キーワード4'
            ],
            size: 'large',
            status: true,
            scene: [
                'marriage',
                'babygift',
                'birthday'
            ],
            character: [
                'pokemon',
                'disney',
                'onepiece'
            ]
        }
    };
    $scope.editProduct = function() {
        console.log($scope.product_data);
        if(location.pathname === '/admin/products/new') {
            $http({
                method: 'POST',
                url: '/api/products/edit',
                data: $scope.product_data
            }).success(function(data, status, headers, config) {
                console.log(data);
                if(data.data.result === 'success') {
                    location.href = "/admin/products";
                }
            }).error(function(data, status, headers, config) {
                console.log(status);
            });
        } else {
            $http({
                method: 'PATCH',
                url: '/api/products/edit',
                data: $scope.product_data
            }).success(function(data, status, headers, config) {
                console.log(data);
                if(data.data.result === 'success') {
                    location.href = "/admin/products";
                }
            }).error(function(data, status, headers, config) {
                console.log(status);
            });
        }
    };
});