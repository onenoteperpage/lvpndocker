#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <ipv4_address> <ipv6_address> <sa_password>"
  exit 1
fi

IPV4_ADDRESS=$1
IPV6_ADDRESS=$2
SA_PASSWORD=$3
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Check if the Docker Compose file exists, and delete it if it does
if [ -f "$DOCKER_COMPOSE_FILE" ]; then
  rm "$DOCKER_COMPOSE_FILE"
  echo "Existing Docker Compose file deleted."
fi

# Create Docker Compose file
cat > "$DOCKER_COMPOSE_FILE" <<EOF
version: '3.8'

services:
  mssql-server:
    image: mcr.microsoft.com/mssql/server
    environment:
      SA_PASSWORD: $SA_PASSWORD
      ACCEPT_EULA: Y
    ports:
      - "1433:1433"
    volumes:
      - mssql-data:/var/opt/mssql
    networks:
      my_ipv4_network:
        ipv4_address: $IPV4_ADDRESS
      my_ipv6_network:
        ipv6_address: $IPV6_ADDRESS

networks:
  my_ipv4_network:
    ipam:
      driver: default
      config:
        - subnet: $IPV4_ADDRESS/32

  my_ipv6_network:
    ipam:
      driver: default
      config:
        - subnet: $IPV6_ADDRESS/128

volumes:
  mssql-data:
EOF

echo "Docker Compose file created with IPv4 address: $IPV4_ADDRESS and IPv6 address: $IPV6_ADDRESS"
