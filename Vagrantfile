Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"
  config.vm.network "forwarded_port", guest: 8000, host: 8000       # Pterodactyl NGINX
  config.vm.network "forwarded_port", guest: 8080, host: 8080       # Wings HTTP daemon
  config.vm.network "forwarded_port", guest: 25565, host: 25565     # Minecraft server
  config.vm.network "forwarded_port", guest: 3000, host: 3000       # Free port allowance
  config.vm.network "forwarded_port", guest: 3001, host: 3001       # Free port allowance
  config.vm.network "forwarded_port", guest: 3002, host: 3002       # Free port allowance

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3072"
   end

  config.vm.provision "shell",
    inline: 'echo $SHELL; env; if [ -z "$PUBLIC_PTERO_IP" ]; then echo "PUBLIC_PTERO_IP is not defined! Check the README!"; exit 1; fi',
    env: {"PUBLIC_PTERO_IP":ENV['PUBLIC_PTERO_IP']}

  config.vm.provision "shell",
    path: "0-install-deps.sh"

  config.vm.provision "shell",
    path: "1-install-ptero.sh"

  config.vm.provision "shell",
    path: "2-install-wings.sh"

  config.vm.provision "shell",
    path: "3-api-config.sh",
    env: {"PUBLIC_PTERO_IP":ENV['PUBLIC_PTERO_IP']}

end