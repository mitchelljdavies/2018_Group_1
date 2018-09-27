#!/usr/bin/env bash

# LOAD BALANCER INSTALL FILE
# This file assumes the following about our instance:
# - That it's running on Linux 2 AMI (might work on other one's too though, not sure if anything about this is unique to Linux 2 AMI)

# HAProxy SETUP
sudo yum update -y && # Install package updates
sudo yum install -y httpd haproxy # Installing Apache & HAProxy
