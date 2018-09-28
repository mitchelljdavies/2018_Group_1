#!/bin/bash

# Our check url function used for assignment 2 / task 3 to check if the frontend of a WordPress website is live
# $1 is the first argument when this program is called eg ./checkurl.sh http://13.236.116.252/
# At this stage we only check for 404 or 500 errors, this could be extended to handle other 5xx or 4xx by turning the grep into regex
# This handles our main purpose which is WordPress being down (which will return a 500 error), other errors like a bad gateway (502) or forbidden (403) doesn't neccessarily denote any action is required

if curl -s --head  --request GET $1 | grep "404" > /dev/null # Check for 404 error on the page
then
  export problemIP=$1 # Store the Public IP as an environment variable
  export problemError="404" # Store the error as an environment variable
  ansible-playbook email.yml #Send the error notification email
fi
if curl -s --head  --request GET $1 | grep "500" > /dev/null # Check for 500 error on the page
then
  export problemIP=$1 # Store the Public IP as an environment variable
  export problemError="500" # Store the error as an environment variable
  ansible-playbook email.yml #Send the error notification email
fi
if curl -s --head  --request GET $1 | grep "200" > /dev/null # Check for 200 success on the page in which case we check the homepage's outbound links
then
  wget -O - $1 | \
  grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | \
  awk '!a[$0]++' | while read line
  do
  	if curl -s --head  --request GET $line | grep "404" > /dev/null # Check for 404 error on the page
  	then
      export problemIP=$1 # Store the Public IP as an environment variable
      export problemError="404_link_$line" # Store the error as an environment variable
      ansible-playbook email.yml #Send the error notification email
  	fi
  	if curl -s --head  --request GET $line | grep "500" > /dev/null # Check for 500 error on the page
  	then
      export problemIP=$1 # Store the Public IP as an environment variable
      export problemError="500_link_$line" # Store the error as an environment variable
      ansible-playbook email.yml #Send the error notification email
  	fi
  done
fi
