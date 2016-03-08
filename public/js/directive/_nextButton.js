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
            if(location.pathname.split('/')[1] === 'search') {
                if(angular.isUndefined(querySortService.min)) {
                    scope.link = {
                        down: scope.url + "?page=" + ( scope.current - 1 ) + "&max=" + querySortService.max,
                        up: scope.url + "?page=" + ( scope.current + 1 ) + "&max=" + querySortService.max
                    };
                } else if(angular.isUndefined(querySortService.max)) {
                    scope.link = {
                        down: scope.url + "?page=" + ( scope.current - 1 ) + "&min=" + querySortService.min,
                        up: scope.url + "?page=" + ( scope.current + 1 ) + "&min=" + querySortService.min
                    };
                } else {
                    scope.link = {
                        down: scope.url + "?page=" + ( scope.current - 1 ) + "&min=" + querySortService.min + "&max=" + querySortService.max,
                        up: scope.url + "?page=" + ( scope.current + 1 ) + "&min=" + querySortService.min + "&max=" + querySortService.max
                    };
                }
            } else {
                if(angular.isUndefined(querySortService.category)) {
                    scope.link = {
                        down: scope.url + '?status=' + querySortService.status + "&page=" + ( scope.current - 1 ),
                        up: scope.url + '?status=' + querySortService.status + "&page=" + ( scope.current + 1 )
                    };
                } else {
                    scope.link = {
                        down: scope.url + '?status=' + querySortService.status + "&page=" + ( scope.current - 1 ) + '&category=' + querySortService.category,
                        up: scope.url + '?status=' + querySortService.status + "&page=" + ( scope.current + 1 ) + '&category=' + querySortService.category
                    };
                }
            }
        }
    };
});