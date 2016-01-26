app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        /***** Public *****/
        .when('/', {
            templateUrl: '/template/public/index.html'
        })
        .when('/products', {
            templateUrl: '/template/public/product/list.html'
        })
        .when('/products/show', {
            templateUrl: '/template/public/product/show.html'
        })
        .when('/carts/show', {
            templateUrl: '/template/public/cart/show.html'
        })
        .when('/carts/register', {
            templateUrl: '/template/public/cart/register.html'
        })
        .when('/carts/comfirm', {
            templateUrl: '/template/public/cart/comfirm.html'
        })
        .when('/carts/thanks', {
            templateUrl: '/template/public/cart/thanks.html'
        })
        .when('/company/privacy', {
            templateUrl: '/template/company/privacy.html'
        })
        /***** Admin *****/
        .when('/admin', {
            templateUrl: '/template/admin/index.html'
        })
        .when('/admin/products', {
            templateUrl: '/template/admin/product/index.html'
        })
        .when('/admin/orders', {
            templateUrl: '/template/admin/order/index.html'
        })
        .when('/admin/categories', {
            templateUrl: '/template/admin/category/index.html'
        })
        .when('/admin/customers', {
            templateUrl: '/template/admin/customer/index.html'
        })
        .when('/admin/settings', {
            templateUrl: '/template/admin/setting/index.html'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);
});