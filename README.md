# Intro

This repo helps provisioning pterodactyl VMs with vagrant and VirtualBox

# Prerequesites

Install :

- Virtual Box : https://www.virtualbox.org/wiki/Downloads
- Vagrant : https://www.vagrantup.com/downloads

## Example setting up the environment on Ubuntu
```shell
sudo apt install -y virtualbox vagrant git
gh repo clone Vanepi-MC/ptero-vagrant
cd ptero-vagrant
vagrant up
```

# Usage

Setting up the virtual machine is as easy as running :

```shell
vagrant up
```

Pterodactyl will then be available on the [host machine on port 8080](http://localhost:8080)