app.controller('contactEditController', function($scope, $http) {
    $scope.formOptions = {
        status: ['未対応', '対応済み']
    };
    $scope.formModel = balloon_data.data.detail_contact;
    $scope.editContact = function() {
        var sendData = {
            data: $scope.formModel
        };
        $http({
            method: 'PATCH',
            url: '/api/contacts/edit',
            data: sendData
        }).success(function(data, status, headers, config) {
            if(data.data.result === 'success') {
                location.href = "/admin";
            } else {
                alert(data.data.message);
            }
        }).error(function(data, status, headers, config) {
            alert(status);
        });
    };
});