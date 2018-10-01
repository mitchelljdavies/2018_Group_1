#!/bin/bash

# We export our variables before every time we run the playbook so that the stay persistent
export webmasterEmail=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_KEY=
ansible-playbook /var/www/html/CheckInstances.yml
