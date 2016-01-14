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

require('angular');
require('angular-resource');
require('angular-route');

var app = angular.module('balloonApp', ['ngRoute', 'ngResource']),
    apiUrl = [
        '/apis/index.json',
        '/apis/admin.json'
    ];

app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        .when('/', {
            templateUrl: '/template/public/index.html',
            controller: 'topPageController'
        })
        .when('/product/scene', {
            templateUrl: '/template/public/product/scene.html'
        })
        .when('/product/show', {
            templateUrl: '/template/public/product/show.html'
        })
        .when('/cart/show', {
            templateUrl: '/template/public/cart/show.html'
        })
        .when('/cart/register', {
            templateUrl: '/template/public/cart/register.html'
        })
        .when('/cart/comfirm', {
            templateUrl: '/template/public/cart/comfirm.html'
        })
        .when('/cart/thanks', {
            templateUrl: '/template/public/cart/thanks.html'
        })
        .when('/admin', {
            templateUrl: '/template/admin/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/product', {
            templateUrl: '/template/admin/product/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/order', {
            templateUrl: '/template/admin/order/index.html',
            controller: 'adminPageController'
        })
        .when('/company/privacy', {
            templateUrl: '/template/company/privacy.html'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);

    /* Rails Ajax Escape */
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
    $scope.path = location.pathname;
    $scope.search = location.search;

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