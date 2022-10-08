#!/bin/bash

cd /var/www/pterodactyl

if [ -z "$PUBLIC_PTERO_IP" ]
then
      export PUBLIC_PTERO_IP=127.0.0.1
fi
echo The following IP will be expected: $PUBLIC_PTERO_IP

cd

# Create an API token in the mySQL database for calling Pterodactyl APIs afterwards
# Token: ptla_SJRT07zt5Ds ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu
echo | sudo mysql -u root << EOF
INSERT INTO panel.api_keys ( user_id, key_type, identifier, memo, created_at, updated_at, token, r_servers, r_nodes, r_allocations, r_users, r_locations, r_nests, r_eggs, r_database_hosts, r_server_databases ) VALUES (  1, 2, 'ptla_SJRT07zt5Ds', 'Vagrant token', now(), now(), 'eyJpdiI6IjhOUkdMemIrd1Y3NXIxM1RXa3NUSlE9PSIsInZhbHVlIjoiNHJlQXd0YlhyNlcwTndRZDBNRVdWTXlRMm5lSXJiNjZHaE5yZStaUDVHMkxyWEF4RHczRkRoVFVWdnhGY3I0KyIsIm1hYyI6IjVjZTBlYmY2OGU0NWM0NzQ0NTYzNWE1ODkzOTUyMmU1ZTk1MjNjOWIwMDZkOThhNDk0MDUxOWY0NDk3Njg5ZWIiLCJ0YWciOiIifQ==' , 3, 3, 3, 3, 3, 3, 3, 3, 3 );
EOF

# Call API for creating a Pterodactly location
curl "http://localhost:8000/api/application/locations" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu' \
  -X POST \
  -d '{
  "short": "VM",
  "long": "My local VM"
}'

# Call API for creating a Pterodactly node
curl "http://localhost:8000/api/application/nodes" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu' \
  -X POST \
  -d '{
  "name": "My Node",
  "location_id": 1,
  "fqdn": "'"$PUBLIC_PTERO_IP"'",
  "scheme": "http",
  "memory": 1024,
  "memory_overallocate": 0,
  "disk": 1024,
  "disk_overallocate": 0,
  "upload_size": 100,
  "daemon_sftp": 2022,
  "daemon_listen": 8080
}'

# Create the default allocation on port 25565
curl "http://localhost:8000/api/application/nodes/1/allocations" \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu' \
  -X POST \
  -d '{
  "ip": "0.0.0.0",
  "ports": [
    "25565"
  ]
}'

# Create the configuration file for wings
cd /etc/pterodactyl && sudo wings configure --panel-url http://$PUBLIC_PTERO_IP:8000 --token ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu --node 1

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
echo | sudo mysql << EOF
UPDATE panel.settings SET value = 0 WHERE key = 'settings::pterodactyl:auth:2fa_required';
EOF

# Create the Database host
echo | sudo mysql << EOF
INSERT INTO panel.database_hosts (name, host, port, username, password) VALUES ( 'dbhost', '127.0.0.1', 3306, 'superadmin', 'eyJpdiI6IjkwY3FSTlZiNXRkbGRMMmxheVg4RGc9PSIsInZhbHVlIjoia3hvb1JVQitjWWdWcmV2bTg3c0tkMFFnREt0amJKaG1DdGFEcGQ4Z0ZkVT0iLCJtYWMiOiI2NTIwMjU1ZTIyYzQ2YTA5NDEwNmYwNjQ1MjdkZmQxMjI3MzIzMWFjMmFmMDMzZGM3Y2ExOGQxNzFmOTcxZmYwIiwidGFnIjoiIn0=' );
EOF

sleep 5 # Wait for the server to be ready

# Create the Minecraft server
SERVER_UUID=$(curl "http://localhost:8000/api/application/servers" \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer ptla_SJRT07zt5DsxqEat0UnzD4YcceNptkDdTKvots0eJmu' \
  -X POST \
  -d '{
  "name": "Minecraft server",
  "user": 1,
  "egg": 5,
  "docker_image": "ghcr.io/pterodactyl/yolks:java_17",
  "startup": "java -Xms128M -XX:MaxRAMPercentage=95.0 -jar {{SERVER_JARFILE}}",
  "environment": {
    "BUNGEE_VERSION": "latest",
    "SERVER_JARFILE": "bungeecord.jar"
  },
  "limits": {
    "memory": 0,
    "swap": 0,
    "disk": 0,
    "io": 500,
    "cpu": "0"
  },
  "feature_limits": {
    "databases": 5,
    "backups": 1
  },
  "allocation": {
    "default": 1
  }
}' | jq -r '.attributes.uuid')

echo Server $SERVER_UUID created !