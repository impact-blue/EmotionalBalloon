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