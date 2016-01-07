lock '3.4.0'

set :application, 'emotional_balloon'
set :repo_url, 'git@github.com:impact-blue/EmotionalBalloon.git'

set :deploy_to, 'var/www/app/EmotionalBalloon'
set :scm, :git

set :keep_releases,5

namespace :deploy do |variable|
end