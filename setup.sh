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

# Do the web configuration
sudo rm /etc/nginx/sites-enabled/default
sudo bash -c 'cat > /etc/nginx/sites-available/pterodactyl.conf <<EOF
server {
    # Replace the example <localhost> with your domain name or IP address
    listen 80;
    server_name localhost;


    root /var/www/pterodactyl/public;
    index index.html index.htm index.php;
    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/pterodactyl.app-error.log error;

    # allow larger file uploads and longer script runtimes
    client_max_body_size 100m;
    client_body_timeout 120s;

    sendfile off;

    location ~ \.php\$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param PHP_VALUE "upload_max_filesize = 100M \n post_max_size=100M";
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param HTTP_PROXY "";
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF'
sudo ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/pterodactyl.conf

# Restarting System Nginx
sudo systemctl restart nginx


#     Instalation Global (Wings)
cd

# Installing and starting "Docker" in the user directory
curl -sSL https://get.docker.com/ | CHANNEL=stable bash
sudo systemctl enable --now docker

# Enable docker swap in grub
sudo rm /etc/default/grub
sudo bash -c 'cat > /etc/default/grub.txt <<EOF
# If you change this file, run '"'"'update-grub'"'"' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n '"'"'Simple configuration'''"'"'

GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="swapaccount=1"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command "vbeinfo"
#GRUB_GFXMODE=640x480

# Uncomment if you dont want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY="true"

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE="480 440 1"
EOF'

#   Installing Wings

# Set repositories
sudo mkdir -p /etc/pterodactyl

# Donwload Wings
sudo curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"

# Creation of the inter-file link (Wings)
sudo chmod u+x /usr/local/bin/wings

# Creation of configuration files
sudo bash -c 'cat > /etc/pterodactyl/config.yml <<EOF
debug: false
uuid: 83374c67-681a-41b5-8598-d1aeb009b0ad
token_id: x35UzI1SHCa9AZmp
token: jt70SD7sfwywiLm9QiDGTEzucCkplACIixkQaL9Yruffd3nzf04nG9xPSSa7KJBF
api:
  host: 0.0.0.0
  port: 8080
  ssl:
    enabled: false
    cert: /etc/letsencrypt/live/192.168.2.32/fullchain.pem
    key: /etc/letsencrypt/live/192.168.2.32/privkey.pem
  upload_limit: 100
system:
  data: /var/lib/pterodactyl/volumes
  sftp:
    bind_port: 2022
allowed_mounts: []
remote: '"'"'http://192.168.2.32:8080'"'"'
EOF'

# Starting Wings
sudo wings --debug

# Running Wings in the background
sudo bash -c 'cat > /etc/systemd/system/wings.service <<EOF
[Unit]
Description=Pterodactyl Wings Daemon
After=docker.service
Requires=docker.service
PartOf=docker.service

[Service]
User=root
WorkingDirectory=/etc/pterodactyl
LimitNOFILE=4096
PIDFile=/var/run/wings/daemon.pid
ExecStart=/usr/local/bin/wings
Restart=on-failure
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF'

# Activating Wings
sudo systemctl enable --now wings

# Optional AF2 Activation
echo | sudo mysql -u root -p << EOF
UPDATE panel.settings SET value = 0 WHERE `key` = 'settings::pterodactyl:auth:2fa_required';
EOF'