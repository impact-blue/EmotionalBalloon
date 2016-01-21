require('angular');
require('angular-resource');
require('angular-route');

var app = angular.module('balloonApp', ['ngRoute', 'ngResource']),
    apiUrl = [
        '/apis/index.json',
        '/apis/admin.json'
    ];