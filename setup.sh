sudo apt update

# Add "add-apt-repository" command
sudo apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg

# Add additional repositories for PHP, Redis, and MariaDB
sudo LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
sudo add-apt-repository ppa:redislabs/redis -y

# MariaDB repo setup script can be skipped on Ubuntu 22.04
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

# Update repositories list
sudo apt update

# Add universe repository if you are on Ubuntu 18.04
sudo apt-add-repository universe

# Install Dependencies
sudo apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server

# Installing Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Download Pterodactly files
sudo mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl
sudo curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
sudo tar -xzvf panel.tar.gz
sudo chmod -R 755 storage/* bootstrap/cache/

# Create the pterodactyl user in mySql
echo | sudo mysql -u root << EOF
CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY 'yourPassword';
CREATE DATABASE panel;
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;
EOF

# Setup composer and generate keys
sudo cp .env.example .env
sudo composer install -n --no-dev --optimize-autoloader
sudo php artisan key:generate --force

# Setup the environment
sudo php artisan p:environment:setup \
  --author=naubert@magesi.com \
  --url=http://localhost \
  --timezone=CET \
  --cache=redis \
  --session=redis \
  --queue=redis \
  --settings-ui=true \
  --redis-host=localhost \
  --redis-pass= \
  --redis-port=6379

sudo php artisan p:environment:database \
  --host=127.0.0.1 \
  --username=pterodactyl \
  --password=yourPassword \
  --port=3306 \
  --database=panel

# Ignoring mail for now
# php artisan p:environment:mail

# Setting up database
sudo php artisan migrate --seed --force

# Creating the first user
sudo php artisan p:user:make \
  --email=naubert@magesi.com \
  --username=naubert \
  --name-first=Noah \
  --name-last=Aubert \
  --password=yourPassword \
  --admin=1

# Set permissions
sudo chown -R www-data:www-data /var/www/pterodactyl/*

# Setup services
sudo systemctl enable --now redis-server
sudo bash -c 'cat > /etc/systemd/system/pteroq.service <<EOF
# Pterodactyl Queue Worker File
# ----------------------------------

[Unit]
Description=Pterodactyl Queue Worker
After=redis-server.service

[Service]
# On some systems the user and group might be different.
# Some systems use `apache` or `nginx` as the user and group.
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php /var/www/pterodactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF'
sudo systemctl enable --now pteroq.service