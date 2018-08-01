!#/usr/bin/env bash

sudo yum update -y && echo *** UPDATES INSTALLED *** #Install updates
#Apache installation
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 && echo *** STEP 1/9 COMPLETE ***
sudo yum install -y httpd mariadb-server && echo *** STEP 2/9 COMPLETE *** #installing Apache, MariaDB, PHP
sudo systemctl start httpd && echo *** STEP 3/9 COMPLETE *** #Start Apache server
sudo systemctl enable httpd && echo *** STEP 4/9 COMPLETE *** #Start Apache at each system boot
sudo usermod -a -G apache ec2-user && echo *** STEP 5/9 COMPLETE *** #Adding ourselves as a user to the apache group
sudo chown -R ec2-user:apache /var/www && echo *** STEP 6/9 COMPLETE *** #Giving the apache group ownership of /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \; && echo *** STEP 7/9 COMPLETE *** #Changing directory permissions
find /var/www -type f -exec sudo chmod 0664 {} \; && echo *** STEP 8/9 COMPLETE *** #Add group write permissions to /var/www

#LAMP server testing
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php && echo LAMP server running and permissions ok

#TODO: mysql_secure_installation (has several prompts that we need to automate)
sudo systemctl enable mariadb && echo *** STEP 9/9 COMPLETE ***

# TASK 1 INSTALL FILE
# This file assumes the following about our instance:
# - That it's running on Linux 2 AMI (might work on other one's too though, not sure if anything about this is unique to Linux 2 AMI)
# - That our LAMP Web Server is already set up (So Linux, Apache, MySQL, PHP is installed)
# - That we've set up the password for the database as "root"
# - The the Apache web server is running and the database server (MariaDB) is running
# TODO: You'll note the wp core install command sets the URL as the public IP for the instance I set this up on, you'll have to change that to the public IP of your instance and we'll need to figure out a way we can automatically set this
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar # Download the WP CLI
chmod +x wp-cli.phar # Make the WP CLI executable
sudo mv wp-cli.phar /usr/local/bin/wp # Put it in our PATH so we can just call "wp"
cd /var/www/html # Navigate to our html directory
wp core download # Download WordPress Core
wp core config --dbname=wp-db --dbuser=root --dbpass=root # Generate our config file
wp db create # Create the database for our WordPress site
wp core install --url="http://13.55.180.175" --title="Assignment 1 WordPress Site" --admin_user="group_1" --admin_password="alpha wario salamander" --admin_email="test@test.co.nz" # Install WordPress and set up our user
