#!/bin/bash

# Our check url function used for assignment 2 / task 3 to check if the frontend of a WordPress website is live
# $1 is the first argument when this program is called eg ./checkurl.sh http://13.236.116.252/
# At this stage we only check for 404 or 500 errors, this could be extended to handle other 5xx or 4xx by turning the grep into regex
# This handles our main purpose which is WordPress being down (which will return a 500 error), other errors like a bad gateway (502) or forbidden (403) doesn't neccessarily denote any action is required

if curl -s --head  --request GET $1 | grep "404" > /dev/null # Check for 404 error on the page
then
   echo "404 $1" # Just echo the error but this can be extended to create a notification
fi
if curl -s --head  --request GET $1 | grep "500" > /dev/null # Check for 500 error on the page
then
   echo "500 $1" # Just echo the error but this can be extended to create a notification
fi
