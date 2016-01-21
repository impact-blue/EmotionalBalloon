require('angular');
require('angular-resource');
require('angular-route');

var app = angular.module('balloonApp', ['ngRoute', 'ngResource']),
    cartItem = [];

if(localStorage.getItem('cart')) {
    cartItem = JSON.parse(localStorage.getItem('cart'));
}