Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "provisioning/setup.sh" 
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  config.vm.synced_folder "web/", "/home/vagrant/web", create: true, owner: "www-data", group: "www-data"
end
