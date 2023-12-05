#!/bin/bash

# Default values
EMAIL=""
IPV4=""
IPV6=""
DOMAIN=""

# Process command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --email)
      shift
      EMAIL="$1"
      ;;
    --ipv4)
      shift
      IPV4="$1"
      ;;
    --ipv6)
      shift
      IPV6="$1"
      ;;
    --domain)
      shift
      DOMAIN="$1"
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

echo "Email: $EMAIL"
echo "IPv4: $IPV4"
echo "IPv6: $IPV6"
echo "Domain: $DOMAIN"

# # Step 1: Update all packages with Alpine Linux
# apk update
# apk upgrade --no-cache

# # Step 2: Install Git
# apk add git docker docker-compose icu-data-full icu-libs tzdata apache2-utils ufw --no-cache

# # Step 3: Setup Docker
# rc-update add docker boot
# service docker start

# # Step 4: SSH
# mkdir -p /root/.ssh
# chmod 700 /root/.ssh
# echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjWFuC84iy2nhO6vqKh9VnrqfipV+l3yheC8vM/k90k hello@lunavpn.co" > /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys
# ufw allow 22/tcp

# # Step 5: Create /app directory
# mkdir -p /app

# # Step 6: Clone the repository into /app/lvpnportal
# git clone https://github.com/repasscloud/lvpnportal.git /app/lvpnportal

# # Step 7: Create /app/caddy directory
# mkdir -p /app/caddy

# # Step 8: Create /app/caddy/Caddyfile
# cat > /app/caddy/Caddyfile <<EOF
# http://uat-portal.lunavpn.co {
#     redir https://uat-portal.lunavpn.co{uri}
# }

# https://uat-portal.lunavpn.co {
#     reverse_proxy lvpnportal:80
#     tls danijel@repasscloud.com
# }
# EOF

# # Step 9: Test if the docker-compose.yml file exists, if it does, delete
# if [ -f "/app/docker-compose.yml" ]; then
#     rm "/app/docker-compose.yml"
#     echo "Existing docker-compose.yml file deleted."
# fi

# # Step 10: Create docker-compose.yml
# cat > /app/docker-compose.yml <<EOF
# version: '3.8'

# services:
#   lvpnportal:
#     build:
#       context: /app/lvpnportal
#       dockerfile: Dockerfile
#     image: lvpnportal:dev
#     container_name: lvpnportal
#     restart: always
#     expose:
#       - "80"
#     networks:
#       - lvpn_network

#   caddy:
#     image: caddy:latest
#     depends_on:
#       - lvpnportal
#     container_name: caddy
#     restart: always
#     ports:
#       - "80:80"
#       - "443:443"
#     networks:
#       - lvpn_network
#     volumes:
#       - /app/caddy/Caddyfile:/etc/caddy/Caddyfile
#       - caddy_data:/data

# volumes:
#   caddy_data:

# networks:
#   lvpn_network:
#     driver: bridge
# EOF

# # Step 11: Setup UFW
# ufw allow 2375/tcp
# ufw allow in on docker0
# ufw allow 22/tcp
# ufw allow 80/tcp
# ufw allow 443/tcp
# ufw --force enable

# # Step 12: Completion
# echo "Setup complete, run 'reboot' to complete"
