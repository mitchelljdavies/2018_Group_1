#!/usr/bin/env bash
cd /etc/haproxy/
sudo systemctl stop haproxy
sudo sed -i 's/frontend  main *:5000/frontend  main *:80/g' /etc/haproxy/haproxy.cfg
sudo sed -i '64,67d' /etc/haproxy/haproxy.cfg
sudo sed -i 's/127.0.0.1:5001/'$IP1:80/g haproxy.cfg
sudo sed -i 's/127.0.0.1:5002/'$IP2:80/g haproxy.cfg
sudo sed -i 's/127.0.0.1:5003/'$IP3:80/g haproxy.cfg
sudo systemctl start haproxy
