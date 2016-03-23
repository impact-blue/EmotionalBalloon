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
    $scope.formModel = {
        name: [
            {
                first_name: "",
                last_name: ""
            }
        ]
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

        console.log($scope.formContent.buyer_info.name);
    }, true);

    $scope.addInput = function() {
        $scope.formModel.name.push({
            family_name: "",
            first_name: ""
        });
    };

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