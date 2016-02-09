app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        /***** Public *****/
        .when('/', {
            templateUrl: '/template/public/index.html'
        })
        .when('/products', {
            templateUrl: '/template/public/product/index.html'
        })
        .when('/products/ranking', {
            templateUrl: '/template/public/product/ranking.html'
        })
        .when('/products/show/:id', {
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
        .when('/original', {
            templateUrl: '/template/public/original/index.html'
        })
        .when('/company/privacy', {
            templateUrl: '/template/company/privacy.html'
        })
        /***** Admin *****/
        .when('/admin', {
            templateUrl: '/template/admin/index.html'
        })
        .when('/admin/login', {
            templateUrl: '/template/admin/login.html'
        })
        .when('/admin/products', {
            templateUrl: '/template/admin/product/index.html'
        })
        .when('/admin/products/new', {
            templateUrl: '/template/admin/product/edit.html'
        })
        .when('/admin/products/:id/edit', {
            templateUrl: '/template/admin/product/edit.html'
        })
        .when('/admin/orders', {
            templateUrl: '/template/admin/order/index.html'
        })
        .when('/admin/categories', {
            templateUrl: '/template/admin/category/index.html'
        })
        .when('/admin/categories/:id/edit', {
            templateUrl: '/template/admin/category/index.html'
        })
        .when('/admin/customers', {
            templateUrl: '/template/admin/customer/index.html'
        })
        .when('/admin/settings/users', {
            templateUrl: '/template/admin/setting/users.html'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);
});