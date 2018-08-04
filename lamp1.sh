#/usr/bin/env bash
sleep 5s
sudo yum update -y
sleep 5s
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sleep 5s
sudo yum install -y httpd mariadb-server
sleep 5s
sudo /usr/bin/systemctl start httpd
sleep 5s
sudo /usr/bin/systemctl enable httpd
sleep 5s
sudo usermod -a -G apache ec2-user
sleep 5s
sudo chown -R ec2-user:apache /var/www
sleep 5s
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
sleep 5s
find /var/www -type f -exec sudo chmod 0664 {} \;
sleep 5s
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
sleep 5s
rm /var/www/html/phpinfo.php
sleep 5s
sudo /usr/bin/systemctl start mariadb
sleep 5s
printf '\ny\ntest\ntest\ny\ny\ny\ny\n' | sudo /usr/bin/mysql_secure_installation
sleep 5s
sudo /usr/bin/systemctl enable mariadb