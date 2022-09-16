# Intro

This repo helps provisioning pterodactyl VMs with vagrant and VirtualBox

# Prerequesites

Install :

- Virtual Box : https://www.virtualbox.org/wiki/Downloads
- Vagrant : https://www.vagrantup.com/downloads

## Example setting up the environment on Ubuntu
```shell
sudo apt install -y virtualbox vagrant git gh vim net-tools
gh auth
-> Avoir plus tard
gh repo clone Vanepi-MC/ptero-vagrant
cd ptero-vagrant
export PUBLIC_PTERO_IP=192.168.2.14
vagrant up
open http://$PUBLIC_PTERO_IP:8000
```

# Usage

Setting up the virtual machine is as easy as running :

```shell
vagrant up
```

Pterodactyl will then be available on the [host machine on port 8000](http://localhost:8000)