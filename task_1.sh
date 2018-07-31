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
