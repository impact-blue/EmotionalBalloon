app.controller('mailEditController', function($scope, $http) {
    $scope.formModel = {
        id: balloon_data.data.detail_mail.id,
        subject: balloon_data.data.detail_mail.subject,
        content: balloon_data.data.detail_mail.content
    };
    $scope.sendTemplate = function() {
        var sendData = {
            data: $scope.formModel
        };
        $http({
            method: 'PATCH',
            url: '/api/mails/edit',
            data: sendData
        }).success(function(data, status, headers, config) {
            if(data.data.result === 'success') {
                location.href = location.href;
            } else {
                alert(data.data.message);
            }
        }).error(function(data, status, headers, config) {
            alert(status);
        });
    };
});