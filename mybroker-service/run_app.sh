#!/bin/bash
echo "Clearing logs..."
sleep 5
truncate -s 0 /log/development.log
echo "Installing gems..."
bundle install
echo "-------------------"
echo "Running rake db:migrate..."
#drop table nacebels if exists
RAILS_ENV=development rake db:drop
sqlite3 db/development.sqlite3 "DROP TABLE IF EXISTS nacebels;"
rake db:migrate
echo "-------------------"

echo "Running rake db:seed..."
rake db:seed
echo "-------------------"

echo "SMTP Creation"
echo "-------------------"
read -p "Enter SMTP address: " smtp_address
read -p "Enter user email: " email
read -p "Enter port: " port
read -s -p "Enter user password: " password
echo "API info"
read -p "Enter API key: " api_key
read -p "Enter API url (quotes from insurer): " api_url

echo "-------------------"
export EMAIL=$email
export EMAIL_PASSWORD=$password
export HOST_SMTP=$smtp_address
export PORT_SMTP=$port
export API_KEY=$api_key
export API_URL=$api_url


echo "Running rails server..."
rails server
