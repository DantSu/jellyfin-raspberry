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