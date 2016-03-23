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
            content: {
                number: "4242-4242-4242-4242",
                exp_month: 11,
                exp_year: 2017,
                cvc: "123",
                name: "KEI KUBO"
            }
        },
        comment: 'HelloWorld!!'
    };
    $scope.formModel = {
        buyer_jointly: [
            {
                first_name: "",
                last_name: ""
            }
        ],
        destination_jointly: [
            {
                first_name: "",
                last_name: ""
            }
        ]
    };
    $scope.comfirmFlag = false;
    // $scope.formFlag = {
    //     buyer_info: {
    //         name: false,
    //         postal: false,
    //         prefectures: false,
    //         address: false,
    //         phone: false,
    //         mail: false
    //     },
    //     destination_info: {
    //         name: false,
    //         postal: false,
    //         prefectures: false,
    //         address: false,
    //         phone: false
    //     },
    //     payment: false
    // };
    // $scope.$watch('formContent', function(value) {
    //     var buyer_name:
    // }, true);

    $scope.addJointly = function(type) {
        if(type === 'buyer') {
            $scope.formModel.buyer_jointly.push({
                family_name: "",
                first_name: ""
            });
        } else if(type === 'destination') {
            $scope.formModel.destination_jointly.push({
                family_name: "",
                first_name: ""
            });
        }
    };

    $scope.sendCart = function() {
        var sendData = {
            data: $scope.formContent
        };
        console.log(sendData);
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