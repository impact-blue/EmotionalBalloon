namespace :deploy do
  desc "deploy"
  task :quit do
    unicorn_signal :QUIT

    cmd = nil
    cmd = "export SECRET_KEY_BASE=`rake secret`"
    puts cmd
    exec cmd
  end

  task :precompile do
    cmd = nil
    cmd = "bundle exec rake assets:precompile RAILS_ENV=production"
    puts cmd
    exec cmd
  end

  task :start do
    cmd = nil
    cmd = "bundle exec unicorn_rails -E production -c config/unicorn.rb"
    puts cmd
    exec cmd
  end

  task deploy: [:quit,:precompile,:start] do
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
