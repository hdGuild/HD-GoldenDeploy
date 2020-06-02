#!/bin/bash
set -euo pipefail

# this script is to deploy letsencrypt on ubuntu lemp server
website='re7.helldorado.fr'
webmail='contact.laguilde@helldorado.fr'

## Step 1 — Installing Certbot
### First, add the repository:
add-apt-repository -y ppa:certbot/certbot 
### Install Certbot’s Nginx package
apt-get -y install python-certbot-nginx

## Step 2 — Confirming Nginx’s Configuration
nginx -t

## Step 3 — Allowing HTTPS Through the Firewall
ufw allow 'Nginx Full'
ufw delete allow 'Nginx HTTP'

## Step 4 — Obtaining an SSL Certificate
# sudo certbot --nginx -d <site> -d www.<site>
certbot --nginx -d $website -d www.$website -m $webmail --agree-tos --no-eff-email


## Step 5 — Verifying Certbot Auto-Renewal
certbot renew --dry-run
