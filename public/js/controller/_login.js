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
});