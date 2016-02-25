app.controller('orderEditController', function($scope, $http) {
    $scope.orderContent = {
        id: balloon_data.data.detail_order.id,
        status: balloon_data.data.detail_order.status,
        product_info: balloon_data.data.detail_order.product_info,
        buyer_info: {
            name: [
                {
                    family_name: balloon_data.data.detail_order.buyer_info.name[0].family_name,
                    first_name: balloon_data.data.detail_order.buyer_info.name[0].first_name,
                }
            ],
            postal_code: balloon_data.data.detail_order.buyer_info.postal_code,
            prefectures: balloon_data.data.detail_order.buyer_info.prefectures,
            address: balloon_data.data.detail_order.buyer_info.address,
            phone: balloon_data.data.detail_order.buyer_info.phone,
            mail: balloon_data.data.detail_order.buyer_info.mail
        },
        destination_info: {
            name: [
                {
                    family_name: balloon_data.data.detail_order.destination_info.name[0].family_name,
                    first_name: balloon_data.data.detail_order.destination_info.name[0].first_name,
                }
            ],
            postal_code: balloon_data.data.detail_order.destination_info.postal_code,
            prefectures: balloon_data.data.detail_order.destination_info.prefectures,
            address: balloon_data.data.detail_order.destination_info.address,
            date: balloon_data.data.detail_order.destination_info.date,
            phone: balloon_data.data.detail_order.destination_info.phone,
            classification: balloon_data.data.detail_order.destination_info.classification
        },
        payment_info: {
            method: balloon_data.data.detail_order.payment_info.method,
            token: balloon_data.data.detail_order.payment_info.token
        },
        comment: null
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