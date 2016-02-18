app.controller('cartRegisterController', function($scope, $http) {
    $scope.stepFlag = 1;
    $scope.prevForm = function() {
        $scope.stepFlag--;
    };
    $scope.nextForm = function() {
        $scope.stepFlag++;
    };

    $scope.progressPer = 0;
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
        buyer_name: false,
        buyer_postal: false,
        buyer_prefectures: false,
        buyer_address: false,
        buyer_phone: false,
        buyer_mail: false,
        destination_name: false,
        destination_postal: false,
        destination_prefectures: false,
        destination_address: false,
        destination_class: false,
        payment: false
    };
    $scope.comfirmFlag = {
        step1: false,
        step2: false,
        step3: false
    };
    $scope.$watch('formContent', function(newVal, oldVal) {
        var flagLength = 0;
        /* Buyer Name */
        if($scope.formContent.buyer_info.name[0].family_name && $scope.formContent.buyer_info.name[0].first_name) {
            $scope.formFlag.buyer_name = true;
        } else {
            $scope.formFlag.buyer_name = false;
        }
        /* Buyer Postal Code */
        if($scope.formContent.buyer_info.postal_code) {
            $scope.formFlag.buyer_postal = true;
        } else {
            $scope.formFlag.buyer_postal = false;
        }
        /* Buyer Prefectures */
        if($scope.formContent.buyer_info.prefectures) {
            $scope.formFlag.buyer_prefectures = true;
        } else {
            $scope.formFlag.buyer_prefectures = false;
        }
        /* Buyer Address */
        if($scope.formContent.buyer_info.address) {
            $scope.formFlag.buyer_address = true;
        } else {
            $scope.formFlag.buyer_address = false;
        }
        /* Buyer Phone */
        if($scope.formContent.buyer_info.phone) {
            $scope.formFlag.buyer_phone = true;
        } else {
            $scope.formFlag.buyer_phone = false;
        }
        /* Buyer Mail */
        if($scope.formContent.buyer_info.mail) {
            $scope.formFlag.buyer_mail = true;
        } else {
            $scope.formFlag.buyer_mail = false;
        }
        /* Destination Name */
        if($scope.formContent.destination_info.name[0].family_name && $scope.formContent.destination_info.name[0].first_name) {
            $scope.formFlag.destination_name = true;
        } else {
            $scope.formFlag.destination_name = false;
        }
        /* Destination Postal Code */
        if($scope.formContent.destination_info.postal_code) {
            $scope.formFlag.destination_postal = true;
        } else {
            $scope.formFlag.destination_postal = false;
        }
        /* Destination Prefecture */
        if($scope.formContent.destination_info.prefectures) {
            $scope.formFlag.destination_prefectures = true;
        } else {
            $scope.formFlag.destination_prefectures = false;
        }
        /* Destination Address */
        if($scope.formContent.destination_info.address) {
            $scope.formFlag.destination_address = true;
        } else {
            $scope.formFlag.destination_address = false;
        }
        /* Destination Phone */
        if($scope.formContent.destination_info.phone) {
            $scope.formFlag.destination_phone = true;
        } else {
            $scope.formFlag.destination_phone = false;
        }
        /* Destination Class */
        /* Payment */

        angular.forEach($scope.formFlag, function(value, key){
            if(value) {
                flagLength++;
            }
        });
        $scope.progressPer = flagLength * 10;

        $scope.comfirmFlag = {
            step1: $scope.formFlag.buyer_name && $scope.formFlag.buyer_postal && $scope.formFlag.buyer_prefectures && $scope.formFlag.buyer_address && $scope.formFlag.buyer_phone && $scope.formFlag.buyer_mail,
            step2: $scope.formFlag.destination_name && $scope.formFlag.destination_postal && $scope.formFlag.destination_prefectures && $scope.formFlag.destination_address && $scope.formFlag.destination_phone,
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