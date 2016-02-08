namespace :deploy do
  desc "deploy"
  task :start do
    unicorn_signal :QUIT
    cmd = "export SECRET_KEY_BASE=`rake secret`"
    puts cmd
    exec cmd

    cmd = "bundle exec rake assets:precompile RAILS_ENV=production"
    puts cmd
    exec cmd

    cmd = "bundle exec unicorn_rails -E production -c config/unicorn.rb"
    puts cmd
    exec cmd
  end

  def unicorn_signal signal
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    begin
      File.read("/var/run/unicorn/unicorn_EmotionalBalloon.pid").to_i
    rescue Errno::ENOENT
      raise "Unicorn doesn't seem to be running"
    end
  end

end
