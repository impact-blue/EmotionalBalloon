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
  after "deploy", "deploy:restart"
end