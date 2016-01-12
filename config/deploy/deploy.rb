lock '3.4.0'

set :application, 'emotional_balloon'
set :repo_url, 'git@github.com:impact-blue/EmotionalBalloon.git'

set :deploy_to, 'var/www/app/EmotionalBalloon'
set :pty,true
set :scm, :git

set :keep_releases,5
set :user,"balloon"
set :password,"impact1234"


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end