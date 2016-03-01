app.service('getStorageService', function() {
    var storageVal = {};
    angular.forEach(localStorage, function(value, key) {
        if(key !== 'debug') {
            storageVal[key] = JSON.parse(value);
        }
    });
    return storageVal;
});