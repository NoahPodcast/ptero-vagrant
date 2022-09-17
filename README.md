# Intro

This repo helps provisioning pterodactyl VMs with vagrant and VirtualBox

# Prerequesites

Install :

- Virtual Box : https://www.virtualbox.org/wiki/Downloads
- Vagrant : https://www.vagrantup.com/downloads

## Examples setting up environment

### Ubuntu
```shell
sudo apt install -y virtualbox vagrant gh net-tools
gh auth
-> Avoir plus tard
gh repo clone Vanepi-MC/ptero-vagrant
cd ptero-vagrant

export PUBLIC_PTERO_IP=$(hostname -I | awk '{print $1}') && vagrant up
open http://$PUBLIC_PTERO_IP:8000
```

### MacOS
```shell
brew install -y virtualbox vagrant gh
gh auth
-> Avoir plus tard
gh repo clone Vanepi-MC/ptero-vagrant
cd ptero-vagrant

export PUBLIC_PTERO_IP=$(ifconfig | grep 'inet[^6].*broadcast' | awk '{print $2}') && vagrant up
open http://$PUBLIC_PTERO_IP:8000
```


# Usage

Setting up the virtual machine is as easy as running :

```shell
vagrant up
```

Pterodactyl will then be available on the [host machine on port 8000](http://localhost:8000)