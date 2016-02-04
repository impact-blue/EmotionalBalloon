Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false


  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false


  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log


  config.active_record.migration_error = :page_load

  config.assets.debug = true


  config.assets.digest = true


  config.assets.raise_runtime_errors = true

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => '587',
  :domain => 'smtp.gmail.com',
  :authentication => 'plain',
  :user_name => 'negai.m.nishimura@gmail.com',
  :password => '81338133'
  }

    config.after_initialize do
    Bullet.enable  = true   # bullet を有効にする

    # 以下はN+1問題を発見した時のユーザーへの通知方法
    Bullet.alert   = true   # ブラウザのJavaScriptアラート
    Bullet.bullet_logger = true # Rails.root/log/bullet.log
    Bullet.console = true   # ブラウザの console.log の出力先
    #Bullet.growl   = true   # Growl
    #Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                :password => 'bullets_password_for_jabber',
    #                :receiver => 'your_account@jabber.org',
    #                :show_online_status => true }
    Bullet.rails_logger = true # Railsのログ
    #Bullet.bugsnag      = true # 総合デバッガツールbugsnag
    #Bullet.airbrake     = true # Airbrake
    #Bullet.raise        = true # Exceptionを発生
    Bullet.add_footer   = true # 画面の下部に表示
    # include paths with any of these substrings in the stack trace,
    # even if they are not in your main app
    #Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
  end
end
