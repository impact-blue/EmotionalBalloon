require('angular');
require('angular-resource');
require('angular-route');
require('angular-bootstrap-datetimepicker');

var app = angular.module('balloonApp', ['ngRoute', 'ngResource', 'ui.bootstrap.datetimepicker']),
    cartItem = [];

if(localStorage.getItem('cart')) {
    cartItem = JSON.parse(localStorage.getItem('cart'));
}
app.controller('adminController', function($scope, $http) {
    $scope.path = location.pathname;
    $scope.search = location.search;
    $scope.data = balloon_data.data;
});
app.controller('balloonController', function($scope, $http) {
    $scope.data = balloon_data.data;
});
app.controller('cartComfirmController', function($scope, $http) {
    $scope.comfirm = {
        data: {
            // product_info: [
            //     {
            //         id: 123,
            //         number: 3
            //     },
            //     {
            //         id: 456,
            //         number: 1
            //     },
            //     {
            //         id: 789,
            //         number: 8
            //     }
            // ],
            // buyer_info: {
            //     family_name: "Wada",
            //     first_name: "Hayato",
            //     jointly: "hatoya",
            //     postal_code: 3560058,
            //     prefectures: "Saitamaken",
            //     address1: "fujiminoshiohichuou1-10-9",
            //     address2: null,
            //     phone: 1111,
            //     mail: "hatoya.web.design@gmail.com"
            // },
            // destination_info: {
            //     family_name: "和田",
            //     first_name: "隼人",
            //     postal_code: 3560058,
            //     prefectures: "埼玉県",
            //     address1: "ふじみ野市大井中央1-10-9",
            //     address2: null,
            //     date: "timestump",
            //     classification: "other"
            // },
            // payment_info: {
            //     method: "credit"
            // },
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