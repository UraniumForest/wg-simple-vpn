# wg-simple-vpn
## Description
This script automates the creation of remote access VPNs, along with other network configurations. It also generates QR codes for client configurations and allows you to check the status of all WireGuard VPNs.

## Important Information
All commands mentioned below must be run as root.

## Important Steps
### DDNS (Required before creating a remote access VPN)
If your server is behind a NAT (e.g., a home router), you must configure DDNS (Dynamic DNS) with a DDNS provider like "No-IP": 

"No-IP" webpage: https://www.noip.com

- You create a hostname and enable DDNS for it:
<br>
<img width="1280" height="586" alt="image" src="https://github.com/user-attachments/assets/84f373a9-6d2b-4dd2-8843-6975d64e8328" />
<br><br>
- You set up a client description and generate a DDNS key: 
<br><br>
<img width="744" height="685" alt="image" src="https://github.com/user-attachments/assets/f911f6ae-2242-4a00-9816-b39f84472e3a" />

- You copy the generated username and password: 

<img width="719" height="660" alt="image" src="https://github.com/user-attachments/assets/a78825cd-a6dd-46b9-b413-9364f95ea368" />

- You access the device that does NAT in your home (e.g., a home router) and configure a DDNS service with the credentials they gave you and the following data:

  - Domain Name: all.ddnskey.com
  - Service provider: no-ip
  - Host of the service provider: dynupdate.no-ip.com
  - Service port: 80

<img width="677" height="487" alt="image" src="https://github.com/user-attachments/assets/170af70b-e145-4be4-8462-9675620ad840" />

### Port forwarding (Required before creating a remote access VPN)
If your server is behind a NAT (e.g., a home router), you must configure Port Forwarding on your router so the external traffic reaches this server's UDP port (e.g., 51820). For example, if the VPN is listening on port 51820, you create a rule to redirect any UDP traffic hitting your router's public IP on port 51820 (external port) to your server's private IP on port 51820 (internal port). 

<img width="678" height="512" alt="image" src="https://github.com/user-attachments/assets/ef673779-b51f-4a35-b35a-2aec6d15f927" />

### Client requirements (Required before Client Setup)
If you specify a DNS server for a Debian/Ubuntu client, the resolvconf package must be installed on that system for the settings to take effect. If it is not installed, run:
```bash
apt update && apt install -y resolvconf
```
## Installation in a virtual machine
If you want to host this tool in a virtual machine, you can use this OVA to import a VM (minimal installation of **Debian 13 (Trixie)**) with all the software needed already installed: 

👉 https://drive.google.com/file/d/1L1ANrRaHF1l_y8CHE5ovecl7NIBZ82Sz/view?usp=sharing

* **User Credentials:** Username: `wg-user` / Password: `Passw0rd!`
* **Root Credentials:** Username: `root` / Password: `Passw0rd!`
* Note: I strongly recommend that you change both passwords immediately using the `passwd wg-user` and `passwd root` commands after your first login.

## Normal Installation
### Install git, clone the repository and navigate into the directory:
```bash
apt update && apt install -y git
git clone https://github.com/UraniumForest/wg-simple-vpn.git
cd wg-simple-vpn
```
### Give execution permission to the installer and run it:
```bash
chmod +x install.sh
./install.sh
```
## Usage
### Create a remote access VPN
Configure the server and multiple clients through a guided wizard.
```bash
wg-simple-vpn add
```
### Display clients configuration in QR codes
Choose a client to display its configuration as a QR code for easy scanning.
```bash
wg-simple-vpn show
```
### Remote access VPNs status
Check handshakes, data transfer, and the state of active tunnels.
```bash
wg-simple-vpn status
```
## Project Structure
### wg-simple-vpn
The main executable script (can be executed from anywhere).

### install.sh
Installation and dependency management script.

### /etc/wireguard/
Directory where server configuration files are stored on the server.

### /etc/wireguard/clients/
Directory where client configuration files are stored on the server.

## Client Setup
First, if you are setting up a Windows or Debian/Ubuntu client, you must transfer the .conf client file to that device. For Mobile devices, this is not necessary as you can simply scan the QR code.

Then, depending on the client's system, follow these steps:

### Android / iOS
- Install the WireGuard app from Google Play Store or Apple App Store.

- Open the app and tap the "+" button.

- Select "Scan from QR code".

- Run `wg-simple-vpn show` on your server, select a client and scan the generated QR code with your phone.

- Give the VPN tunnel a name and switch it ON.

### Windows
- Download and install the Official WireGuard App.

- Click "Add Tunnel" and select your .conf file.

- Click "Activate" to connect to the VPN.

### Debian / Ubuntu
```bash
# Install Wireguard
apt update && apt install -y wireguard

# Replace 'client.conf' with your actual filename
cp client.conf /etc/wireguard/

# (Optional) Enable auto-connect to the VPN on boot (replace 'client' with your filename without .conf)
systemctl enable wg-quick@client

# Connect to the VPN right now (replace 'client' with your filename without .conf)
systemctl start wg-quick@client
```
If you want to stop the connection with the VPN, run the following command (replace 'client' with your filename without .conf): 
```bash
systemctl stop wg-quick@client
```
## System Requirements For Server
OS: Debian 11+, Ubuntu 22.04+.
