require 'active_record'

namespace :db do
  desc "Dumps the database"
  task backup: [:environment, :load_config] do

    environment = Rails.env
    configuration = ActiveRecord::Base.configurations[environment]
    db_server = "153.120.166.128"
    db_esc_path = ENV['~/var/backup_mysql'] # ファイルのバックアップ先のパス
    timestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    backup_file = "#{db_esc_path}/#{timestamp}.dump"

    cmd = nil
    cmd = "MYSQL_PWD=#{configuration['password']} mysqldump -h #{db_server} -u #{configuration['username']} #{configuration['database']} > ~/var/backup_mysql#{backup_file}"

    puts cmd
    exec cmd
  end
end