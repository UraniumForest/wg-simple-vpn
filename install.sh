#!/bin/bash

umask 077
set -e
set -u

green='\033[0;32m'
bold='\033[1m'
nc='\033[0m'

clear
echo -e "${green}${bold}=== Starting wg-simple-vpn Installation ===${nc}"

# Root check
if [[ "$EUID" -ne 0 ]]; then
    echo -e "\nError: This script must be run with sudo.\n"
    exit 1
fi

# Dependency Installation
echo -e "\n${bold}1. Installing required packages...${nc}"
apt update && apt install -y wireguard-tools qrencode iptables iproute2

# Directory Structure
echo -e "\n${bold}2. Creating configuration directories...${nc}"
mkdir -p /etc/wireguard/clients

# Command Integration
echo -e "\n${bold}3. Installing the management script...${nc}"
# Assuming your main script is in the same folder as this installer
cp wg-simple-vpn /usr/local/bin/wg-simple-vpn
chmod +x /usr/local/bin/wg-simple-vpn

echo -e "\n${green}${bold}=== Installation Completed Successfully ===${nc}"
echo -e "\nYou can now use the command: ${bold}wg-simple-vpn${nc}"
echo
