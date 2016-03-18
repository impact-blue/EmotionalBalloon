app.service('localStorageService', function() {
    this.load = function() {
        var storageVal = {};
        angular.forEach(localStorage, function(value, key) {
            if(key !== 'debug') {
                storageVal[key] = JSON.parse(value);
            }
        });
        return storageVal;
    };
    this.save = function(array, id) {
        if(angular.isUndefined(array)) {
            array = [];
        }
        array.push(id);
        localStorage.setItem('cart', JSON.stringify(array));
    };
    this.delete = function(array, id) {
        array.splice(id, 1);
        angular.forEach(array, function(value, key) {
            if(value === id) {
                array.splice(key, 1);
            }
        });
        localStorage.setItem('cart', JSON.stringify(array));
    };
});