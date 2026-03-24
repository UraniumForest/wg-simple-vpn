# wg-simple-vpn
## Explanation
This script automates the creation of remote access VPNs, along with other network configurations. It also generates QR codes for client configurations and allows you to check the status of all WireGuard VPNs.

## Installation
### Clone the repository:
```bash
git clone https://github.com/UraniumForest/wg-simple-vpn
cd wg-simple-vpn
```
### Give execution permission to the installer and run it:
```bash
chmod +x install.sh
sudo ./install.sh
```
## Usage
### Create a remote access VPN

Configure the server and multiple clients through a guided wizard.
```bash
sudo wg-simple-vpn add
```
### Display clients configuration in QR codes

Choose a client to display its configuration as a QR code for easy scanning.
```bash
sudo wg-simple-vpn show
```
### Remote access VPNs status

Check handshakes, data transfer, and the state of active tunnels.
```bash
sudo wg-simple-vpn status
```
## Project Structure
wg-simple-vpn: The main executable script (can be executed from anywhere).

install.sh: Installation and dependency management script.

/etc/wireguard/: Directory where server configuration files are stored.

/etc/wireguard/clients/: Directory where client configuration files are stored.

## Important steps
Port Forwarding: If your server is behind a NAT (e.g., a home router), you must configure Port Forwarding on your router so the external traffic reaches this server's UDP port (e.g., 51820).

## System Requirements
OS: Debian 11+, Ubuntu 20.04+.
