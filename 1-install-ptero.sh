#!/bin/bash

cd /var/www/pterodactyl

# Create the pterodactyl user in mySql
echo | sudo mysql -u root << EOF
CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY 'yourPassword';
CREATE DATABASE panel;
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;
EOF

# Create the superadmin user in mySql
echo | sudo mysql -u root << EOF
CREATE USER 'superadmin'@'127.0.0.1' IDENTIFIED BY 'yourPassword';
GRANT ALL PRIVILEGES ON *.* TO 'superadmin'@'127.0.0.1' WITH GRANT OPTION;
EOF

# Setup composer and generate keys
sudo cp .env.example .env
sudo composer install -n --no-dev --optimize-autoloader
sudo php artisan key:generate --force

# For now we will enforce using a static Laraval encryption key so our hardcoded tokens in the database can keep functioning
# TODO: Would be better to get mySQL to computer the Laraval encrypted keys from dynamic key created by artisan
sudo sed -i 's/APP_KEY=.*/APP_KEY=base64:E4elE0kuWbKEMr7P7X6LBRmS96o7o4hi1NCrbcbde3I=/' .env


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
  --email=email@example.com \
  --username=admin \
  --name-first=Prenom \
  --name-last=Famille \
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
    listen 8000;
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
