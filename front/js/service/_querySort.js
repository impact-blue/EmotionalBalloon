app.service('querySortService', function() {
    var queryVal = {};
    if(location.search) {
        angular.forEach(location.search.split('?')[1].split('&'), function(val, key) {
            queryVal[val.split('=')[0]] = val.split('=')[1];
        });
        return queryVal;
    }
});