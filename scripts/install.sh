#!/bin/sh
sudo yum install -y httpd
service start httpd
chkconfig httpd on
echo "<html><h1>Hello from mlabouardy ^^</h2></html>" > /var/www/html/index.html
