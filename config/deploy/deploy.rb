lock '3.4.0'

set :application, 'emotional_balloon'
set :repo_url, 'git@github.com:impact-blue/EmotionalBalloon.git'
set :deploy_to, 'var/www/app/EmotionalBalloon'

set :pty,true
set :scm, :git

set :keep_releases,5
set :user,"balloon"
set :use_sudo, true
set :password,"impact1234"



namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:db), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'delayed_job:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end