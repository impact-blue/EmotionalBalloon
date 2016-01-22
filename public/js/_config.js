app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        .when('/', {
            templateUrl: '/template/public/index.html'
        })
        .when('/products/scene', {
            templateUrl: '/template/public/product/scene.html'
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
        .when('/admin', {
            templateUrl: '/template/admin/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/products', {
            templateUrl: '/template/admin/product/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/orders', {
            templateUrl: '/template/admin/order/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/categories', {
            templateUrl: '/template/admin/category/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/customers', {
            templateUrl: '/template/admin/customer/index.html',
            controller: 'adminPageController'
        })
        .when('/admin/settings', {
            templateUrl: '/template/admin/setting/index.html',
            controller: 'adminPageController'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);

    console.log('hi');
});