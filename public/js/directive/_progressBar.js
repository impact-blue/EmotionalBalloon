app.directive('balloonProgressBar', function() {
    return {
        restrict: "E",
        templateUrl: '/parts/progressBar.html',
        replace: true,
        scope: {
            per: "=per",
        }
    };
});