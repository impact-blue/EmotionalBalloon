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
    ngAnnotate = require('gulp-ng-annotate'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream');

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

gulp.task('js:develop', function(callback){
    runSequence('concat:develop', 'browserify:develop', callback);
});

gulp.task('concat:develop', function(){
    gulp.src(['./front/js/_balloon.js', './front/js/_config.js', './front/js/controller/*.js', './front/js/directive/*.js'])
        .pipe(plumber())
        .pipe(concat('develop.js'))
        .pipe(gulp.dest('./front/js'));
});

gulp.task('browserify:develop', function(){
    browserify({entries: ['./front/js/develop.js']})
        .bundle()
        .pipe(plumber())
        .pipe(source('application.js'))
        .pipe(gulp.dest('./front/js/'));
});

gulp.task('concat:build', function(){
    gulp.src(['./front/js/_balloon.js', './front/js/controller/*.js', './front/js/directive/*.js'])
        .pipe(plumber())
        .pipe(concat('build.js'))
        .pipe(gulp.dest('./front/js'));
});

gulp.task('browserify:build', function(){
    browserify({entries: ['./front/js/build.js']})
        .bundle()
        .pipe(plumber())
        .pipe(source('application.min.js'))
        .pipe(gulp.dest('./front/js/'));
});

gulp.task('copy', function(){
    gulp
        .src(['./front/css/**'])
        .pipe(gulp.dest('./public/css'));
    gulp
        .src(['./front/js/**'])
        .pipe(gulp.dest('./public/js'));
    gulp
        .src(['./front/img/**'])
        .pipe(gulp.dest('./public/img/'));
    gulp
        .src(['./front/template/**'])
        .pipe(gulp.dest('./public/template/'));
    gulp
        .src(['./front/template/public/index.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/top/'));
    gulp
        .src(['./front/template/public/product/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/products/'));
    gulp
        .src(['./front/template/public/cart/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/carts/'));
    gulp
        .src(['./front/template/admin/index.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin/'));
    gulp
        .src(['./front/template/admin/product/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_products/'));
    gulp
        .src(['./front/template/admin/order/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_orders/'));
    gulp
        .src(['./front/template/admin/category/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_categories/'));
    gulp
        .src(['./front/template/admin/customer/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_customers/'));
    gulp
        .src(['./front/template/admin/setting/*.html'])
        .pipe(rename('index.html.erb'))
        .pipe(gulp.dest('./app/views/admin_users/'));
});

gulp.task('ejs', function(){
    gulp
        .src(['./front/ejs/**/*.ejs', '!./front/ejs/**/_*.ejs'])
        .pipe(ejs())
        .pipe(gulp.dest('./front/template/'));
});

gulp.task('watch', function(){
    gulp.watch(['./front/scss/**/*.scss'], ['sass']);
    gulp.watch(['./front/js/**/_*.js'], ['js:develop']);
    gulp.watch(['./front/ejs/**/*.ejs'], ['ejs']);
    gulp.watch(['./front/html.html', './front/template/*.html', './front/css/application.css', './front/js/application.js'], function(){
        browserSync.reload();
    });
});

gulp.task('default', function() {
    runSequence('sass', 'js:develop', 'ejs', 'connect', 'watch');
});
gulp.task('build', function(callback){
    runSequence('sass', 'concat:build', 'browserify:build', 'ejs', 'copy', callback);
});