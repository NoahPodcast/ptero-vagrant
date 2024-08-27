# Ptero Vagrant - Development Tool
---
![alt text](docs/ressources/logo-tools.png)

---

### Quick Links
- [English Documentation](#-english-documentation)
- [Documentation Française](docs/fr_readme.md)

---
## 🇬🇧 English Documentation
---
### Introduction

**Ptero Vagrant - Development Tool** is a powerful and flexible tool designed to automate the configuration and management of [Pterodactyl](https://pterodactyl.io/)-based VPS panels, using [Vagrant](https://www.vagrantup.com/). This tool allows users to easily create, configure and manage virtual machines, giving them the freedom to do whatever they want with their machines using [Ubuntu 22.04 LTS (Linux distributions)](https://www.ubuntu-fr.org/). It's simply a Linux machine with a pre-configured [Pterodactyl](https://pterodactyl.io/) server manager.

> [!NOTE]
> Key features include:
> - **Automated Environment Setup**: Quickly spin up VPS panels with predefined configurations.
> - **Consistency**: Ensure all users are working in identical environments, >reducing "it works on my machine" issues.
> - **Flexibility**: Easily modify and extend configurations to suit specific needs.
> - **Isolation**: Keep environments isolated from the host machine, preventing conflicts and ensuring clean setups.

Whether you are setting up a small VPS panel or managing a large-scale application, **Ptero Vagrant - Development Tool** provides the tools you need to maintain a productive and efficient workflow.

---

> [!CAUTION]
> **Warning Note**: This tool is intended solely for development purposes and is not designed for production server hosting. It contains security vulnerabilities such as weak passwords and publicly available encryption keys. Using this tool for hosting live servers is strongly discouraged.

---
### How to run? (You need to open your terminal)
---
#### With Linux:
Now you can install: [GIT](https://git-scm.com/downloads), [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) with this command.

> [!TIP]
> In this case, we use apt because we use [Ubuntu](https://www.ubuntu-fr.org/) for the example but you can use: apk, yum and more.

```shell
sudo apt install -y virtualbox vagrant git
```
You will need to clone the project with [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Go to your repository
```shell
cd ptero-vagrant
```
Launch the tool with this command.
```shell
export PUBLIC_PTERO_IP=$(hostname -I | awk '{print $1}') && vagrant up
```
After the ending of the instalation, you can put this address into your browser.

    http://localhost:8000

---
#### With MacOS

> [!CAUTION]
> **Warning Note**: If you have an M1, M2, M3, M4, or M5 CPU, VirtualBox does not support virtualization for these processors. Only Intel or AMD chip users can proceed.

> [!IMPORTANT]
> If you don't have HomeBrew on MacOS, you will need to install it with this command in your terminal.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Now you can install: [GIT](https://git-scm.com/downloads), [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) with this command.
```shell
brew install -y virtualbox vagrant git
```
You will need to clone the project with [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Go to your repository
```shell
cd ptero-vagrant
```
Launch the tool with this command.
```shell
export PUBLIC_PTERO_IP=$(hostname -I | awk '{print $1}') && vagrant up
```
After the ending of the instalation, you can put this address into your browser.

    http://localhost:8000

---
#### With Windows 
##### Dependencies:
- [GIT](https://git-scm.com/downloads):
- [Vagrant:](https://developer.hashicorp.com/vagrant/install#windows)
- [Virtualbox:](https://www.virtualbox.org/wiki/Downloads)

For [GIT](https://git-scm.com/downloads) download it with this command
```PowerShell
winget install --id Git.Git -e --source winget
```
> [!IMPORTANT]
> For the Windows User, don't use the CMD, YOU NEED TO EXECUTE BY POWERSHELL!

#### Installation:
Go into your Desktop
```PowerShell
cd Desktop
```
You will need to clone the project with [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Go to your repository
```shell
cd ptero-vagrant
```
Launch the tool with this command.
```Powershell
$Env:PUBLIC_PTERO_IP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.PrefixOrigin -eq 'Dhcp' }).IPAddress; vagrant up
```
After the ending of the instalation, you can put this address into your browser.

    http://localhost:8000

---
### Default Variable
#### Forwarded Port

| Guest | Host | Usage |
|:------:|:------:|:------:|
| 8000   | 8000   | **Pterodactyl NGINX**   |
| 8080   | 8080   | **Wings HTTP daemon**   |
| 25565   | 25565   | **Minecraft server**   |
| 3000   | 3000   | **Free port allowance**   |
| 3001   | 3001   | **Free port allowance**   |
| 3002   | 3002   | **Free port allowance**   |

#### Pterodactyl - Default Admin user

| E-Mail | Password |
|:------:|:------:|
| email@example.com   | **yourPassword**   |

#### Pterodactyl - Default Panel Database user

| User | Password |
|:------:|:------:|
| pterodactyl'@'127.0.0.1   | **yourPassword**   |

#### Pterodactyl - Default Admin Database user for Pterodactyl

| User | Password |
|:------:|:------:|
| superadmin'@'127.0.0.1   | **yourPassword**   |


#### Encryption Key for the Panel Database

    Private Key: E4elE0kuWbKEMr7P7X6LBRmS96o7o4hi1NCrbcbde3I

#### Token for Pterodactyl's APIs
    Token: ptla_SJRT07zt5Ds ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu

For others question please referee to these Documentation:
- [Vagrant Documentation:](https://developer.hashicorp.com/vagrant/docs)
- [GIT Documentation:](https://git-scm.com/doc)
- [Pterodactyl Documentation:](https://pterodactyl.io/project/introduction.html)


**If your problem persists, please go to the [support server](https://discord.gg/HzEPtxstzt)**

[![alt text](docs/ressources/discord.png)](https://discord.gg/HzEPtxstzt)