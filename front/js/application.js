// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


(function() {

    var app = angular.module('balloonApp', ['ngRoute', 'ngResource']),
        apiUrl = [
            '/apis/index.json',
            '/apis/admin.json'
        ];

    app.config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/template/index.html',
                controller: 'topPageController'
            })
            .when('/admin', {
                templateUrl: '/template/admin/index.html',
                controller: 'adminPageController'
            })
            .when('/admin/order/:status', {
                templateUrl: '/template/admin/order/index.html',
                controller: 'adminPageController'
            })
            .when('/company/privacy', {
                templateUrl: '/template/company/privacy.html'
            })
            .otherwise({
                redirectTo: '/'
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

    app.controller('adminPageController', function($scope, $http) {

        $http({
            method: 'GET',
            url: apiUrl[1]
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