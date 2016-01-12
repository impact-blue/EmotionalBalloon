set :staging, :production
set :branch, :master
set :rails_env, :production
set :unicorn_rack_env, "production"



role :app, %w{balloon@153.120.168.115}
role :web, %w{balloon@153.120.168.115}
role :db, %w{balloon@153.120.168.115}
set :ssh_options, {
                    keys: [File.expand_path('~/.ssh/id_rsa.pub')],
                    forward_agent: true
                }