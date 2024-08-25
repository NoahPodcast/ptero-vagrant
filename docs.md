# Ptero Vagrant - Developpement Tools
---
![alt text](docs/ressources/logo-tools.png)

---

### Quick Links
- [English Documentation](#-english-documentation)
- [Documentation Française](#-documentation-française)

---
## 🇬🇧 English Documentation
---
### Introduction

**Ptero Vagrant - Development Tools** is a powerful and flexible tool designed to automate the configuration and management of [Pterodactyl](https://pterodactyl.io/)-based VPS panels, using [Vagrant](https://www.vagrantup.com/). This tool allows users to easily create, configure and manage virtual machines, giving them the freedom to do whatever they want with their machines using [Ubuntu 22.04 LTS (Linux distributions)](https://www.ubuntu-fr.org/). It's simply a Linux machine with a pre-configured [Pterodactyl](https://pterodactyl.io/) server manager.

> [!NOTE]
> Key features include:
> - **Automated Environment Setup**: Quickly spin up VPS panels with predefined configurations.
> - **Consistency**: Ensure all users are working in identical environments, >reducing "it works on my machine" issues.
> - **Flexibility**: Easily modify and extend configurations to suit specific needs.
> - **Isolation**: Keep environments isolated from the host machine, preventing conflicts and ensuring clean setups.

Whether you are setting up a small VPS panel or managing a large-scale application, **Ptero Vagrant - Development Tools** provides the tools you need to maintain a productive and efficient workflow.

---

> [!CAUTION]
> **Warning Note**: This tool is intended solely for development purposes and is not designed for production server hosting. It contains security vulnerabilities such as weak passwords and publicly available encryption keys. 
Using this tool for hosting live servers is strongly discouraged.

---
### How to run? (You need to open your terminal)
---
#### With Linux:
Now you can install: [GIT](https://git-scm.com/downloads), [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant) and VirtualBox with this command.

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
- [Virtualbox:](https://www.virtualbox.org/wiki/Downloadswiki/Downloads)

For [GIT](https://git-scm.com/downloads) download it with this command
```PowerShell
winget install --id Git.Git -e --source winget
```

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

---

## 🇫🇷 Documentation Française
---
### Introduction

**Ptero Vagrant - Outils de développement** est un outil puissant et flexible conçu pour automatiser la configuration et la gestion des panneaux VPS basés sur [Pterodactyl](https://pterodactyl.io/), en utilisant [Vagrant](https://www.vagrantup.com/). Cet outil permet aux utilisateurs de créer, configurer et gérer facilement des machines virtuelles, leur donnant la liberté de faire ce qu'ils veulent avec leurs machines en utilisant Ubuntu 22.04 LTS (distributions Linux). C'est simplement une machine Linux avec un gestionnaire de serveur [Pterodactyl](https://pterodactyl.io/) préconfiguré.

> [!NOTE]
> Les principales fonctionnalités incluent :
> - **Configuration de l'environnement automatisée** : Créez rapidement des panneaux VPS avec des configurations prédéfinies.
> - **Consistance** : Assurez-vous que tous les utilisateurs travaillent dans des environnements identiques, réduisant ainsi les problèmes de type "ça fonctionne sur ma machine".
> - **Flexibilité** : Modifiez et étendez facilement les configurations pour répondre à des besoins spécifiques.
> - **Isolation** : Gardez les environnements isolés de la machine hôte, évitant les conflits et garantissant des configurations propres.

Que vous configuriez un petit panneau VPS ou que vous gériez une application à grande échelle, Ptero Vagrant - Outils de développement vous fournit les outils dont vous avez besoin pour maintenir un flux de travail productif et efficace.

---

> [!CAUTION]
> **Note d'avertissement** : Cet outil est destiné uniquement à des fins de développement et n'est pas conçu pour l'hébergement de serveurs de production. Il contient des vulnérabilités de sécurité telles que des mots de passe faibles et des clés de chiffrement disponibles publiquement. L'utilisation de cet outil pour l'hébergement de serveurs en direct est fortement déconseillée.

---
### Comment exécuter ? (Vous devez ouvrir votre terminal)
---
#### Avec Linux :
Vous pouvez maintenant installer : [GIT](https://git-scm.com/downloads), [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant) et [VirtualBox](https://www.virtualbox.org/wiki/Downloads) avec cette commande.

> [!TIP]
> Dans ce cas, nous utilisons apt car nous utilisons Ubuntu pour l'exemple, mais vous pouvez utiliser : apk, yum et plus encore.

```shell
sudo apt install -y virtualbox vagrant git
```
Vous devrez cloner le projet avec [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Accédez à votre dépôt
```shell
cd ptero-vagrant
```
Lancez l'outil avec cette commande.
```shell
export PUBLIC_PTERO_IP=$(hostname -I | awk '{print $1}') && vagrant up
```
Après la fin de l'installation, vous pouvez mettre cette adresse dans votre navigateur.

    http://localhost:8000

---
#### Avec MacOS

> [!IMPORTANT]
> Si vous n'avez pas HomeBrew sur MacOS, vous devrez l'installer avec cette commande dans votre terminal.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Vous pouvez maintenant installer : [GIT](https://git-scm.com/downloads), [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant) et [VirtualBox](https://www.virtualbox.org/wiki/Downloads) avec cette commande.
```shell
brew install -y virtualbox vagrant git
```
Vous devrez cloner le projet avec [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Accédez à votre dépôt
```shell
cd ptero-vagrant
```
Lancez l'outil avec cette commande.
```shell
export PUBLIC_PTERO_IP=$(hostname -I | awk '{print $1}') && vagrant up
```
Après la fin de l'installation, vous pouvez mettre cette adresse dans votre navigateur.

    http://localhost:8000

---
#### Avec Windows
##### Dépendances :
- [GIT](https://git-scm.com/downloads) :
- [Vagrant :](https://developer.hashicorp.com/vagrant/install#windows)
- [Virtualbox :](https://www.virtualbox.org/wiki/Downloadswiki/Downloads)

Pour [GIT](https://git-scm.com/downloads), téléchargez-le avec cette commande
```PowerShell
winget install --id Git.Git -e --source winget
```

#### Installation :
Allez dans votre bureau
```PowerShell
cd Bureau
```
Vous devrez cloner le projet avec [GIT](https://git-scm.com/downloads).
```shell
git clone git@github.com:Aesthy-Minecraft/ptero-vagrant.git
```
Accédez à votre dépôt
```shell
cd ptero-vagrant
```
Lancez l'outil avec cette commande.
```Powershell
$Env:PUBLIC_PTERO_IP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.PrefixOrigin -eq 'Dhcp' }).IPAddress; vagrant up
```
Après la fin de l'installation, vous pouvez mettre cette adresse dans votre navigateur.

    http://localhost:8000

---
### Variable par défaut
#### Port redirigé

| Invité | Hôte | Utilisation |
|:------:|:------:|:------:|
| 8000   | 8000   | **Pterodactyl NGINX**   |
| 8080   | 8080   | **Démon HTTP Wings**   |
| 25565   | 25565   | **Serveur Minecraft**   |
| 3000   | 3000   | **Autorisation de port libre**   |
| 3001   | 3001   | **Autorisation de port libre**   |
| 3002   | 3002   | **Autorisation de port libre**   |

#### Pterodactyl - Utilisateur administrateur par défaut

| E-Mail | Mot de passe |
|:------:|:------:|
| email@example.com   | **yourPassword**   |

#### Pterodactyl - Utilisateur de base de données du panneau par défaut

| Utilisateur | Mot de passe |
|:------:|:------:|
| pterodactyl'@'127.0.0.1   | **yourPassword**   |

#### Pterodactyl - Utilisateur de base de données administrateur par défaut pour Pterodactyl

| Utilisateur | Mot de passe |
|:------:|:------:|
| superadmin'@'127.0.0.1   | **yourPassword**   |


#### Clé de chiffrement pour la base de données du panneau

    Clé privée : E4elE0kuWbKEMr7P7X6LBRmS96o7o4hi1NCrbcbde3I

#### Jeton pour les API de Pterodactyl
    Jeton : ptla_SJRT07zt5Ds ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu

Pour d'autres questions, veuillez vous référer à ces documentations :
- [Documentation Vagrant :](https://developer.hashicorp.com/vagrant/docs)
- [Documentation GIT :](https://git-scm.com/doc)
- [Documentation Pterodactyl :](https://pterodactyl.io/project/introduction.html)


**Si votre problème persiste, veuillez vous rendre sur le [serveur de support](https://discord.gg/HzEPtxstzt)**

[![alt text](docs/ressources/discord.png)](https://discord.gg/HzEPtxstzt)

---

