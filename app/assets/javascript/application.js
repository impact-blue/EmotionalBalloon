(function() {

    var app = angular.module('balloonApp', ['ngRoute', 'ngResource']),
        apiUrl = [
            '/apis/index.json'
        ];

    app.config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/template/index.html',
                controller: 'topPageController'
            })
            .otherwise({
                redirectTo: '/'
            });

        $locationProvider.html5Mode({
            enabled: true,
            requireBase: false
        });

        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    });

    app.controller('topPageController', function($scope, $http) {

        $http({
            method: 'GET',
            url: apiUrl[0]
        }).success(function(data, status, headers, config) {
            $scope.data = data.data;
        });

    });

    $(window).scroll(function() {
        if($(window).scrollTop() >= 500) {
            $('#js-header').addClass('on');
        } else {
            $('#js-header').removeClass('on');
        }
    });
}());