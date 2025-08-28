Download : https://www.raspberrypi.com/software/

Ouvrir Raspberry pi imager

Choisir le modele > Raspberry pi other > Raspberry pi OS Lite 64 (Sans desktop)

Aller sur 192.168.1.254 > réseau DHCP pour retrouver l'IP v4 de Raspberry

## Définir une IP statique :

Appuyer plusieurs fois sur ECHAP pour quitter nmtui.

```sh
sudo nmtui
sudo reboot
```

## Installer Docker :

```sh
cd ~
sudo apt-get update && sudo apt-get upgrade
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker [user_name]
sudo systemctl enable docker
rm get-docker.sh
```

## Connaitre ID d'un utilisateur

```sh
id [user_name]
```

## Créer les dossiers

```sh
mkdir Jellyfin
mkdir Jellyfin/Downloads
mkdir Jellyfin/Downloads/radarr
mkdir Jellyfin/Downloads/sonarr
mkdir Jellyfin/Films
mkdir Jellyfin/Series
mkdir Jellyfin/Config
mkdir Jellyfin/Config/rdtclient
mkdir Jellyfin/Config/jellyseerr
mkdir Jellyfin/Config/sonarr
mkdir Jellyfin/Config/radarr
mkdir Jellyfin/Config/prowlarr
mkdir Jellyfin/Config/jellyfin
mkdir Jellyfin/Share
```

# Run docker-compose.yml

```sh
nano docker-compose.yml
docker network create "shared_network"
sudo docker compose up -d
```

# Eteindre

```sh
sudo shutdown -h now
```

# partage de fichiers SMB

```sh
sudo apt-get install cifs-utils
nano ~/.smbcredentials
```

Contenu de `.smbcredentials` :

```apacheconf
username=smb_user_name
password=smb_password
domain=WORKGROUP
```

Ensuite lancer :

```sh
chmod 0600 ~/.smbcredentials
sudo nano /etc/fstab
```

Ajouter à la fin de fstab :

```
//192.168.1.100/files /home/[USER_NAME]/Jellyfin/Share cifs credentials=/home/[USER_NAME]/.smbcredentials,x-systemd.automount,iocharset=utf8,rw,uid=1000,gid=1000,vers=2.1 0 0
```

Finir avec :

```sh
systemctl daemon-reload
sudo mount -a
```