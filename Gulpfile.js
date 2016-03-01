var gulp = require('gulp'),
    connect = require('gulp-connect'),
    ngrok = require('ngrok'),
    sass = require('gulp-sass'),
    concat = require('gulp-concat'),
    plumber = require('gulp-plumber'),
    notify = require('gulp-notify'),
    runSequence = require('run-sequence'),
    rename = require('gulp-rename'),
    uglify = require('gulp-uglify'),
    browserSync = require('browser-sync'),
    modRewrite = require('connect-modrewrite'),
    ejs = require('gulp-ejs'),
    ngAnnotate = require('gulp-ng-annotate'),
    browserify = require('gulp-browserify'),
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
    gulp.src(['./front/scss/awesome/_font-awesome.scss', './front/scss/foundation/*.scss', './front/scss/layout/*.scss', './front/scss/object/**/*.scss'])
        .pipe(plumber({errorHandler: notify.onError('<%= error.message %>')}))
        .pipe(concat('application.scss'))
        .pipe(sass())
        .pipe(gulp.dest('./front/css'));
});

gulp.task('js', function(){
    gulp.src(['./front/js/_balloon.js', './front/js/_config.js', './front/js/controller/*.js', './front/js/directive/*.js'])
        .pipe(plumber({errorHandler: notify.onError('<%= error.message %>')}))
        .pipe(concat('application.js'))
        .pipe(browserify())
        .pipe(gulp.dest('front/js'));
});

gulp.task('js:build', function(){
    gulp.src(['./front/js/_balloon.js', './front/js/controller/*.js', './front/js/directive/*.js'])
        .pipe(plumber())
        .pipe(concat('application.min.js'))
        .pipe(browserify())
        .pipe(gulp.dest('front/js'));
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
        .src(['./front/fonts/**'])
        .pipe(gulp.dest('./public/fonts/'));
    /***** Public *****/
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
    /***** Admin *****/
    gulp
        .src(['./front/template/admin/index.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin/'));
    gulp
        .src(['./front/template/admin/products/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_products/'));
    gulp
        .src(['./front/template/admin/orders/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_orders/'));
    gulp
        .src(['./front/template/admin/categories/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_categories/'));
    gulp
        .src(['./front/template/admin/customers/*.html'])
        .pipe(rename(function(path) {
            path.extname = '.html.erb';
        }))
        .pipe(gulp.dest('./app/views/admin_customers/'));
    gulp
        .src(['./front/template/admin/settings/*.html'])
        .pipe(rename('index.html.erb'))
        .pipe(gulp.dest('./app/views/admin_users/'));
    gulp
        .src(['./front/template/admin/login.html'])
        .pipe(rename('new.html.erb'))
        .pipe(gulp.dest('./app/views/sessions/'));
});

gulp.task('ejs', function(){
    gulp
        .src(['./front/ejs/**/*.ejs', '!./front/ejs/**/_*.ejs'])
        .pipe(ejs())
        .pipe(gulp.dest('./front/template/'));
});

gulp.task('watch', function(){
    gulp.watch(['front/scss/**/*.scss'], ['sass']);
    gulp.watch(['front/js/**/_*.js'], ['js']);
    gulp.watch(['front/ejs/**/*.ejs'], ['ejs']);
    gulp.watch(['front/index.html', 'front/ejs/**/*.ejs', 'front/css/application.css', 'front/js/application.js'], function(){
        browserSync.reload();
    });
});

gulp.task('default', ['sass', 'js', 'ejs', 'connect', 'watch']);
gulp.task('build', function(){
    runSequence('sass', 'js:build', 'ejs', 'copy');
});