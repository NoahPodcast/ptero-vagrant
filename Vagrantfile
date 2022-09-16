Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"
  config.vm.network "forwarded_port", guest: 8000, host: 8000       # Pterodactyl NGINX
  config.vm.network "forwarded_port", guest: 8080, host: 8080       # Wings HTTP daemon

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3072"
   end

  config.vm.provision "shell",
    path: "setup.sh",
    env: {"PUBLIC_PTERO_IP":ENV['PUBLIC_PTERO_IP']}

end
