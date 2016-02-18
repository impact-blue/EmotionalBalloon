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
                name: [
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    }
                ],
                postal_code: 3560058,
                prefectures: "Saitamaken",
                address1: "fujiminoshiohichuou1-10-9",
                address2: null,
                phone: 1111,
                mail: "hatoya.web.design@gmail.com"
            },
            destination_info: {
                name: [
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    },
                    {
                        family_name: "Wada",
                        first_name: "Hayato",
                    }
                ],
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
app.controller('cartRegisterController', function($scope, $http) {
    $scope.stepFlag = 1;
    $scope.prevForm = function() {
        $scope.stepFlag--;
    };
    $scope.nextForm = function() {
        $scope.stepFlag++;
    };

    $scope.progressPer = [0, 0, 0];
    $scope.formContent = {
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
            name: [
                {
                    family_name: null,
                    first_name: null,
                }
            ],
            postal_code: null,
            prefectures: null,
            address: null,
            phone: null,
            mail: null
        },
        destination_info: {
            name: [
                {
                    family_name: null,
                    first_name: null,
                }
            ],
            postal_code: null,
            prefectures: null,
            address: null,
            date: null,
            classification: null
        },
        payment_info: {
            method: "credit",
            token: "cus_cWq8H4al7ceo9bs"
        },
        comment: null
    };
    $scope.formFlag = {
        buyer_info: {
            name: false,
            postal: false,
            prefectures: false,
            address: false,
            phone: false,
            mail: false
        },
        destination_info: {
            name: false,
            postal: false,
            prefectures: false,
            address: false,
            phone: false
        },
        payment: false
    };
    $scope.comfirmFlag = {
        step1: false,
        step2: false,
        step3: false
    };
    $scope.$watch('formContent', function(newVal, oldVal) {
        var flagLength = [0, 0, 0];
        /* Buyer Name */
        if($scope.formContent.buyer_info.name[0].family_name && $scope.formContent.buyer_info.name[0].first_name) {
            $scope.formFlag.buyer_info.name = true;
        } else {
            $scope.formFlag.buyer_info.name = false;
        }
        /* Buyer Postal Code */
        if($scope.formContent.buyer_info.postal_code) {
            $scope.formFlag.buyer_info.postal = true;
        } else {
            $scope.formFlag.buyer_info.postal = false;
        }
        /* Buyer Prefectures */
        if($scope.formContent.buyer_info.prefectures) {
            $scope.formFlag.buyer_info.prefectures = true;
        } else {
            $scope.formFlag.buyer_info.prefectures = false;
        }
        /* Buyer Address */
        if($scope.formContent.buyer_info.address) {
            $scope.formFlag.buyer_info.address = true;
        } else {
            $scope.formFlag.buyer_info.address = false;
        }
        /* Buyer Phone */
        if($scope.formContent.buyer_info.phone) {
            $scope.formFlag.buyer_info.phone = true;
        } else {
            $scope.formFlag.buyer_info.phone = false;
        }
        /* Buyer Mail */
        if($scope.formContent.buyer_info.mail) {
            $scope.formFlag.buyer_info.mail = true;
        } else {
            $scope.formFlag.buyer_info.mail = false;
        }
        /* Destination Name */
        if($scope.formContent.destination_info.name[0].family_name && $scope.formContent.destination_info.name[0].first_name) {
            $scope.formFlag.destination_info.name = true;
        } else {
            $scope.formFlag.destination_info.name = false;
        }
        /* Destination Postal Code */
        if($scope.formContent.destination_info.postal_code) {
            $scope.formFlag.destination_info.postal = true;
        } else {
            $scope.formFlag.destination_info.postal = false;
        }
        /* Destination Prefecture */
        if($scope.formContent.destination_info.prefectures) {
            $scope.formFlag.destination_info.prefectures = true;
        } else {
            $scope.formFlag.destination_info.prefectures = false;
        }
        /* Destination Address */
        if($scope.formContent.destination_info.address) {
            $scope.formFlag.destination_info.address = true;
        } else {
            $scope.formFlag.destination_info.address = false;
        }
        /* Destination Phone */
        if($scope.formContent.destination_info.phone) {
            $scope.formFlag.destination_info.phone = true;
        } else {
            $scope.formFlag.destination_info.phone = false;
        }
        /* Destination Class */
        /* Payment */

        angular.forEach($scope.formFlag.buyer_info, function(value, key){
            if(value) {
                flagLength[0]++;
            }
        });
        $scope.progressPer[0] = flagLength[0] * 100 / 6;
        angular.forEach($scope.formFlag.destination_info, function(value, key){
            if(value) {
                flagLength[1]++;
            }
        });
        $scope.progressPer[1] = flagLength[1] * 100 / 5;
        if($scope.formFlag.payment) {
            $scope.progressPer[2] = 100;
        }

        $scope.comfirmFlag = {
            step1: $scope.formFlag.buyer_info.name && $scope.formFlag.buyer_info.postal && $scope.formFlag.buyer_info.prefectures && $scope.formFlag.buyer_info.address && $scope.formFlag.buyer_info.phone && $scope.formFlag.buyer_info.mail,
            step2: $scope.formFlag.destination_info.name && $scope.formFlag.destination_info.postal && $scope.formFlag.destination_info.prefectures && $scope.formFlag.destination_info.address && $scope.formFlag.destination_info.phone,
            step3: true
        };
    }, true);

    $scope.sendCart = function() {
        var sendData = {
            data: $scope.formContent
        };
        $http({
            method: 'POST',
            url: '/api/carts/comfirm',
            data: sendData
        }).success(function(data, status, headers, config) {
            if(data.data.result === 'success') {
                location.href = "/carts/thanks";
            } else {
                alert(data.data.message);
            }
        }).error(function(data, status, headers, config) {
            alert(status);
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
    $scope.handleKeydown = function(e) {
        if(e.which === 13) {
            $scope.loginPost();
        }
    };
});
app.controller('productCreateController', function($scope, $http) {
    $scope.product_data = {
        id: balloon_data.data.detail_product.id,
        name: balloon_data.data.detail_product.name,
        price: balloon_data.data.detail_product.price,
        stock: balloon_data.data.detail_product.stocks,
        images: [
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720172",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720173",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720174",
            "http://uds.gnst.jp/rest/img/s3a4fr5t0000/s_00m9.jpg?t=1401720175"
        ],
        description: balloon_data.data.detail_product.description,
        size: balloon_data.data.detail_product.size,
        status: balloon_data.data.detail_product.status,
        scenes: [],
        characters: []
    };
    $scope.editProduct = function() {
        var sendData = {
            data: $scope.product_data
        };
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
app.directive('balloonProgressBar', function() {
    return {
        restrict: "E",
        templateUrl: '/parts/progressBar.html',
        replace: true,
        scope: {
            per: "=per",
        }
    };
});