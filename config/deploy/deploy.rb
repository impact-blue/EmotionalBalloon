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
  Rake::Task["deploy:updating"].clear_actions
  task :updating => :new_release_path do
    #invoke "#{scm}:create_release" gitを使わないので不要
    # 代わりに、wgetでMavenリポジトリからjar/warファイルをダウンロードするようにする
    on release_roles :all do
      execute :mkdir, '-p', release_path
      execute :wget, "#{fetch(:m2repo)}/#{fetch(:group)}/#{fetch(:application)}/#{fetch(:version)}/#{fetch(:application)}-#{fetch(:version)}.war -P #{release_path}"
    end

    #invoke "deploy:set_current_revision" gitを使わないので不要
    # 代わりに、入力させたバージョンをREVISIONファイルに書き込む
    on release_roles :all do
      within release_path do
        execute :echo, "\"#{fetch(:version)}\" >> REVISION"
      end
    end

    invoke 'deploy:symlink:shared'
  end
end