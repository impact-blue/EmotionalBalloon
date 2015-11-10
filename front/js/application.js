(function() {
    $(window).scroll(function() {
        if($(window).scrollTop() >= 500) {
            $('#js-header').addClass('on');
        } else {
            $('#js-header').removeClass('on');
        }
    });
}());