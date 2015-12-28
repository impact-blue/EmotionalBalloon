Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.ssh.username = "centos"

  config.vm.provider :sakura do |sakura|
    sakura.access_token = '01b7ea6c-6322-4779-941b-6e8973219e61'
    sakura.access_token_secret = 'NGe6bK6DGmTsoOfIR6on3nc3AvcVNQKhakqIPAQae8bdVVmQKffdLGgR4Eot8l6i'
    sakura.use_insecure_key = true
  end
end