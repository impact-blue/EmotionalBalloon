require('angular');
require('angular-resource');
require('angular-route');
require('angular-bootstrap-datetimepicker');

var app = angular.module('balloonApp', ['ngRoute', 'ngResource', 'ui.bootstrap.datetimepicker']),
    cartItem = [];

if(localStorage.getItem('cart')) {
    cartItem = JSON.parse(localStorage.getItem('cart'));
}
app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        /***** Public *****/
        .when('/', {
            templateUrl: '/template/public/index.html'
        })
        .when('/products', {
            templateUrl: '/template/public/product/index.html'
        })
        .when('/products/ranking', {
            templateUrl: '/template/public/product/ranking.html'
        })
        .when('/products/show/:id', {
            templateUrl: '/template/public/product/show.html'
        })
        .when('/carts/show', {
            templateUrl: '/template/public/cart/show.html'
        })
        .when('/carts/register', {
            templateUrl: '/template/public/cart/register.html'
        })
        .when('/carts/comfirm', {
            templateUrl: '/template/public/cart/comfirm.html'
        })
        .when('/carts/thanks', {
            templateUrl: '/template/public/cart/thanks.html'
        })
        .when('/original', {
            templateUrl: '/template/public/original/index.html'
        })
        .when('/company/privacy', {
            templateUrl: '/template/company/privacy.html'
        })
        /***** Admin *****/
        .when('/admin', {
            templateUrl: '/template/admin/index.html'
        })
        .when('/admin/login', {
            templateUrl: '/template/admin/login.html'
        })
        .when('/admin/products', {
            templateUrl: '/template/admin/product/index.html'
        })
        .when('/admin/products/new', {
            templateUrl: '/template/admin/product/edit.html'
        })
        .when('/admin/products/:id/edit', {
            templateUrl: '/template/admin/product/edit.html'
        })
        .when('/admin/orders', {
            templateUrl: '/template/admin/order/index.html'
        })
        .when('/admin/categories', {
            templateUrl: '/template/admin/category/index.html'
        })
        .when('/admin/categories/:id/edit', {
            templateUrl: '/template/admin/category/index.html'
        })
        .when('/admin/customers', {
            templateUrl: '/template/admin/customer/index.html'
        })
        .when('/admin/settings/users', {
            templateUrl: '/template/admin/setting/users.html'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);
});
app.controller('adminController', function($scope, $http) {
    $scope.path = location.pathname;
    $scope.search = location.search;
    $scope.data = balloon_data.data;
    console.log($scope.search);
});
app.controller('balloonController', function($scope, $http) {
    $scope.data = balloon_data.data;
});
app.controller('cartComfirmController', function($scope, $http) {
    $scope.comfirm = {
        data: {
            product_info: [
                {
                    id: 12,
                    count: 3
                },
                {
                    id: 45,
                    count: 1
                },
                {
                    id: 78,
                    count: 8
                }
            ],
            buyer_info: {
                family_name: "Wada",
                first_name: "Hayato",
                jointly: "hatoya",
                postal_code: 3560058,
                prefectures: "Saitamaken",
                address1: "fujiminoshiohichuou1-10-9",
                address2: null,
                phone: 1111,
                mail: "hatoya.web.design@gmail.com"
            },
            destination_info: {
                family_name: "和田",
                first_name: "隼人",
                postal_code: 3560058,
                prefectures: "埼玉県",
                address1: "ふじみ野市大井中央1-10-9",
                address2: null,
                date: "timestump",
                classification: "other"
            },
            payment_info: {
                method: "credit"
            },
            comment: "Hello, World!!"
        }
    };
    $scope.cartComfirm = function() {
        $http({
            method: 'POST',
            url: '/api/carts/comfirm',
            data: $scope.comfirm
        }).success(function(data, status, headers, config) {
            console.log(data);
            if(data.data.result === 'success') {
                location.href = "/carts/thanks";
            }
        }).error(function(data, status, headers, config) {
            console.log(status);
        });
    };
});
app.controller('cartShowController', function($scope, $http) {
    $scope.cartItem = cartItem;
    $scope.data = {};
    angular.forEach($scope.cartItem, function(value, key){
        $http({
            method: 'GET',
            url: '/api/products/detail.json'
        }).success(function(data, status, headers, config) {
            angular.merge($scope.data, data.data);
        });
    });
});
app.controller('loginController', function($scope, $http) {
    $scope.loginInfo = {
        session: {
            email: '',
            password: ''
        }
    };
    $scope.loginPost = function() {
        if($scope.loginInfo.session.email && $scope.loginInfo.session.password) {
            $http({
                method: 'POST',
                url: '/admin/login',
                data: $scope.loginInfo
            }).success(function(data, status, headers, config) {
                if(data.data.result === 'success') {
                    location.href = "/admin";
                }
            }).error(function(data, status, headers, config) {
                console.log(status);
            });
        }
    };
});
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
            size: 230,
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
app.controller('productShowController', function($scope, $http) {
    $scope.is_cart = false;
    $scope.cartItem = cartItem;
    angular.forEach($scope.cartItem, function(value, key){
        if($scope.data.id === value) {
            $scope.is_cart = true;
        }
    });

    $scope.toCart = function(id, flag) {
        var tmpItem = $scope.cartItem;
        $scope.cartItem = [];
        $scope.is_cart = !$scope.is_cart;
        angular.forEach(tmpItem, function(value, key){
            if(id !== value) {
                $scope.cartItem.push(value);
            }
        });
        if(flag) {
            $scope.cartItem.push(id);
        }
        localStorage.setItem("cart", JSON.stringify($scope.cartItem));
    };
});
app.directive('hobbeeBreadCrumb', function(){
    return {
        restrict: 'E',
        templateUrl: 'partials/ninja-customer.html'
    };
});