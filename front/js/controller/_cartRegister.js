app.controller('cartRegisterController', function($scope, $http) {
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
                    family_name: "",
                    first_name: "",
                }
            ],
            postal_code: "",
            prefectures: "",
            address: "",
            phone: "",
            mail: ""
        },
        destination_info: {
            name: [
                {
                    family_name: "",
                    first_name: "",
                }
            ],
            postal_code: "",
            prefectures: "",
            address: "",
            phone: "",
            date: "",
            classification: ""
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
    $scope.$watch('formContent', function(value) {
        var buyer_info = {
                name: value.buyer_info.name[0].family_name.length > 0 && value.buyer_info.name[0].first_name.length > 0,
                postal: value.buyer_info.postal_code.length > 0,
                prefectures: value.buyer_info.prefectures.length > 0,
                address: value.buyer_info.address.length > 0,
                phone: value.buyer_info.phone.length > 0,
                mail: value.buyer_info.mail.length > 0
            },
            destination_info = {
                name: value.destination_info.name[0].family_name.length > 0 && value.destination_info.name[0].first_name.length > 0,
                postal: value.destination_info.postal_code.length > 0,
                prefectures: value.destination_info.prefectures.length > 0,
                address: value.destination_info.address.length > 0,
                phone: value.destination_info.phone.length > 0
            },
            payment_info = value.payment_info.method !== '';
        $scope.comfirmFlag = buyer_info.name && buyer_info.postal && buyer_info.prefectures && buyer_info.address && buyer_info.phone && buyer_info.mail && destination_info.name && destination_info.postal && destination_info.prefectures && destination_info.address && destination_info.phone && payment_info;
        console.log($scope.comfirmFlag);
    }, true);

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

    $scope.is_comfirm = false;
    $scope.comfirmRegister = function() {
        $scope.is_comfirm = !$scope.is_comfirm;
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