var gulp = require('gulp'),
    connect = require('gulp-connect'),
    ngrok = require('ngrok'),
    sass = require('gulp-ruby-sass'),
    concat = require('gulp-concat'),
    plumber = require('gulp-plumber'),
    notify = require('gulp-notify'),
    runSequence = require('run-sequence'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat-util'),
    uglify = require('gulp-uglify'),
    browserSync = require('browser-sync'),
    modRewrite = require('connect-modrewrite');

gulp.task('connect', function(){
    browserSync({
        server: {
            middleware: [modRewrite(['!\\.\\w+$ /index.html [L]'])],
        },
        port: 8888,
        open: false,
    });
    ngrok.connect(8888, function(error, url) {
        console.log('[ngrok] ' + url);
    });
});

gulp.task('sass', function(){
    sass('./scss/application.scss', {style: 'expanded'})
        .pipe(plumber({errorHandler: notify.onError('<%= error.message %>')}))
        .pipe(gulp.dest('./css'));
});

gulp.task('watch', function(){
    gulp.watch(['./scss/**/*.scss'], ['sass']);
    gulp.watch(['./*.html', './css/application.css', './js/application.js'], function(){
        browserSync.reload();
    });
});

gulp.task('default', ['sass', 'connect', 'watch']);