#!/usr/bin/env bash
cd /var/www/html
sudo systemctl stop httpd
wp core download --force
wp core update --force
IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
wp db drop --yes
wp db create
wp core install --url="http://$IP" --title="Assignment 2 WordPress Server 2" --admin_user="group_1" --admin_password="alpha wario salamander" --admin_email="test@test.co.nz"
sudo systemctl start httpd
