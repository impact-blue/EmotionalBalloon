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
            baseDir: "front/",
            middleware: [modRewrite(['!\\.\\w+$ /index.html [L]'])]
        },
        port: 8888,
        open: false
    });
    ngrok.connect(8888, function(error, url) {
        console.log('[ngrok] ' + url);
    });
});

gulp.task('copy', function() {
    gulp
        .src(['./front/css/**'])
        .pipe(gulp.dest('./app/assets/stylesheets/'));
    gulp
        .src(['./front/js/**'])
        .pipe(gulp.dest('./app/assets/javascript/'));
    gulp
        .src(['./front/index.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/top/'));
});

gulp.task('sass', function(){
    sass('./front/scss/application.scss', {style: 'expanded'})
        .pipe(plumber({errorHandler: notify.onError('<%= error.message %>')}))
        .pipe(gulp.dest('./front/css'));
});

gulp.task('watch', function(){
    gulp.watch(['./front/scss/**/*.scss'], ['sass']);
    gulp.watch(['./front/*.html', './front/css/application.css', './front/js/application.js'], function(){
        browserSync.reload();
    });
});

gulp.task('default', ['sass', 'connect', 'watch']);
gulp.task('build', function() {
    runSequence('sass', 'copy');
});