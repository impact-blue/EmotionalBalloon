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
    modRewrite = require('connect-modrewrite'),
    ejs = require('gulp-ejs'),
    ftp = require('gulp-ftp');

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

gulp.task('sass', function(){
    sass('./front/scss/application.scss', {style: 'expanded'})
        .pipe(plumber({errorHandler: notify.onError('<%= error.message %>')}))
        .pipe(gulp.dest('./front/css'));
});

gulp.task('copy', function() {
    gulp
        .src(['./front/css/**'])
        .pipe(gulp.dest('./app/assets/stylesheets/'));
    gulp
        .src(['./front/js/**'])
        .pipe(gulp.dest('./app/assets/javascript/'));
    gulp
        .src(['./front/img/**'])
        .pipe(gulp.dest('./public/img/'));
    gulp
        .src(['./front/template/index.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/top/'));
});

gulp.task('ejs', function() {
    gulp
        .src(['./front/ejs/**/*.ejs', '!./front/ejs/**/_*.ejs'])
        .pipe(ejs())
        .pipe(gulp.dest('./front/template/'));
});

gulp.task('ftp', function() {
    gulp
        .src(['./front/**/*'])
        .pipe(ftp({
            host: 'ftp.1614f910438e6c32.lolipop.jp',
            user: 'lolipop.jp-1614f910438e6c32',
            pass: 'impact-blue2013',
            remotePath: '/balloon'
        }));
});

gulp.task('watch', function(){
    gulp.watch(['./front/scss/**/*.scss'], ['sass']);
    gulp.watch(['./front/ejs/**/*.ejs'], ['ejs']);
    gulp.watch(['./**/*.html', './front/css/application.css', './front/js/application.js'], function(){
        browserSync.reload();
    });
});

gulp.task('default', ['sass', 'ejs', 'connect', 'watch']);
gulp.task('build', function() {
    runSequence('sass', 'ejs', 'copy');
});
gulp.task('deploy', function(){
    runSequence('sass', 'ejs', 'ftp');
});