(function() {

    var app = angular.module('balloonApp', ['ngRoute', 'ngResource']);

    app.config(function($routeProvider, $locationProvider) {
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
    });

    app.controller('topPageController', function($scope, $http) {

        $http({
            method: 'GET',
            url: '/json/topPage.json'
        }).success(function(data, status, headers, config) {
            $scope.data = data.data;
            console.log($scope.data);
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