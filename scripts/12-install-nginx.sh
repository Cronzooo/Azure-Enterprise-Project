#!/bin/bash
# Steps to install and configure NGINX on the Ubuntu VM
# Run these commands inside the VM (connected via Bastion)
# This is NOT a script to run on your Mac

# Update package list
sudo apt update

# Install NGINX
sudo apt install nginx -y

# Verify NGINX is running
sudo systemctl status nginx

# Customize the homepage
echo "<h1>Hello from Cronzo Inc web server (vm-web-prod-westeu-001)</h1>" | sudo tee /var/www/html/index.nginx-debian.html

# Test the page locally
curl http://localhost