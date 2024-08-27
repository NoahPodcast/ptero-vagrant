# Ptero Vagrant - Developpement Tools
---
![alt text](ressources/logo-tools.png)

---

### Quick Links
- [English Documentation](../README.md)
- [Documentation Française](#-documentation-française)

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

> **Note d'avertissement**: Si vous avez un processeur M1, M2, M3, M4 ou M5, VirtualBox ne prend pas en charge la virtualisation pour ces processeurs. Seuls les utilisateurs de puces Intel ou AMD peuvent continuer.

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
- [Virtualbox :](https://www.virtualbox.org/wiki/Downloads)

Pour [GIT](https://git-scm.com/downloads), téléchargez-le avec cette commande
```PowerShell
winget install --id Git.Git -e --source winget
```
> [!IMPORTANT]
> Pour l'utilisateur Windows, n'utilisez pas le CMD, VOUS DEVEZ EXÉCUTER PAR POWERSHELL !

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

[![alt text](ressources/discord.png)](https://discord.gg/HzEPtxstzt)

---