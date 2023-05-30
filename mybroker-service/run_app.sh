#!/bin/bash
echo "Clearing logs..."
sleep 5
truncate -s 0 /log/development.log
echo "Installing gems..."
bundle install
echo "-------------------"
echo "Running rake db:migrate"
rake db:migrate
echo "-------------------"

echo "SMTP Creation"
echo "-------------------"
read -p "Enter SMTP address: " smtp_address
read -p "Enter user email: " email
read -p "Enter port: " port
read -s -p "Enter user password: " password

echo "-------------------"
export EMAIL=$email
export EMAIL_PASSWORD=$password
export HOST_SMTP=$smtp_address
export PORT_SMTP=$port


echo "Running rails server..."
rails s
