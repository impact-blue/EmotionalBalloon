set :staging, :production
set :branch, :master
set :rails_env, :production
set :unicorn_rack_env, "production"



server '153.120.168.115', roles: %w(app web db), primary: true, user: 'balloon'
set :ssh_options, {
                    keys: [File.expand_path('~/.ssh/id_rsa.pub')],
                    forward_agent: true
                }