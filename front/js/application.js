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


    $(window).scroll(function() {
        if($(window).scrollTop() >= 500) {
            $('#js-header').addClass('on');
        } else {
            $('#js-header').removeClass('on');
        }
    });
}());