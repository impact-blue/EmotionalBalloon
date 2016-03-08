app.config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
        /***** Public *****/
        .when('/', {
            templateUrl: '/template/public/index.html'
        })
        .when('/scenes/:scene', {
            templateUrl: '/template/public/products/index.html'
        })
        .when('/characters/:character', {
            templateUrl: '/template/public/products/index.html'
        })
        .when('/search', {
            templateUrl: '/template/public/products/index.html'
        })
        .when('/ranking', {
            templateUrl: '/template/public/products/ranking.html'
        })
        .when('/products/:id', {
            templateUrl: '/template/public/products/show.html'
        })
        .when('/carts/show', {
            templateUrl: '/template/public/carts/show.html'
        })
        .when('/carts/register', {
            templateUrl: '/template/public/carts/register.html'
        })
        .when('/carts/comfirm', {
            templateUrl: '/template/public/carts/comfirm.html'
        })
        .when('/carts/thanks', {
            templateUrl: '/template/public/carts/thanks.html'
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
            templateUrl: '/template/admin/products/index.html'
        })
        .when('/admin/products/new', {
            templateUrl: '/template/admin/products/edit.html'
        })
        .when('/admin/products/:id/edit', {
            templateUrl: '/template/admin/products/edit.html'
        })
        .when('/admin/orders', {
            templateUrl: '/template/admin/orders/index.html'
        })
        .when('/admin/orders/:id/edit', {
            templateUrl: '/template/admin/orders/edit.html'
        })
        .when('/admin/categories', {
            templateUrl: '/template/admin/categories/index.html'
        })
        .when('/admin/categories/:type/:id/edit', {
            templateUrl: '/template/admin/categories/edit.html'
        })
        .when('/admin/customers', {
            templateUrl: '/template/admin/customers/index.html'
        })
        .when('/admin/contacts', {
            templateUrl: '/template/admin/contacts/index.html'
        })
        .when('/admin/mails', {
            templateUrl: '/template/admin/mails/index.html'
        })
        .when('/admin/settings', {
            templateUrl: '/template/admin/settings/users.html'
        })
        .otherwise({
            redirectTo: '/'
        }
    );

    /* HTML5 MODE */
    $locationProvider.html5Mode(true);
});