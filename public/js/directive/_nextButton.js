app.directive('balloonNextButton', function(querySortService) {
    return {
        restrict: "E",
        templateUrl: '/parts/nextButton.html',
        replace: true,
        scope: {
            url: "@url",
            current: "=current",
            max: "=max"
        },
        link: function(scope, element, attrs) {
            scope.link = {
                down: scope.url + "?page=" + ( scope.current - 1 ) + "&min=" + querySortService.min + "&max=" + querySortService.max,
                up: scope.url + "?page=" + ( scope.current + 1 ) + "&min=" + querySortService.min + "&max=" + querySortService.max
            };
        }
    };
});