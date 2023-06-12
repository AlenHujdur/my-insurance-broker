# README
This is a sample README file for a broker service. It should be updated to reflect the broker service's purpose and functionality.

## Prerequisites for production on GCP Cloud Run
Follow instructions on the following link:
https://cloud.google.com/ruby/rails/run
.env file with the following variables:
PRODUCTION_DB_NAME= mybrokerinsurance
PRODUCTION_DB_USERNAME= <pg_user_here>
PRODUCTION_DB_HOST= /cloudsql/mybrokerinsurance:europe-west1:mybrokerinstance
CLOUD_SQL_CONNECTION_NAME= mybrokerinsurance:europe-west1:mybrokerinstance
GOOGLE_PROJECT_ID= mybrokerinsurance
STORAGE_BUCKET_NAME= mybrokerinsurance-bucket1
API_URL= <api_url_here>
API_KEY= <api_key_here>
INSTANCE_NAME= mybrokerinstance
DATABASE_NAME= mybrokerinsurance
REGION=europe-west1
DEVSHELL_PROJECT_ID= europe-west1:mybrokerinstance
BUCKET_NAME= mybrokerinsurance-bucket1
EMAIL= <your_email_here>
EMAIL_PASSWORD= <your_password_here>
HOST_SMTP= <host_smtp_here>
PORT_SMTP= <smtp_port_here>
APP_NAME= mybrokerservice
ORIGIN= https://mybrokerinsurance.ew.r.appspot.com

## Prerequisites for Rails development on localhost
To start rails locally, you need to run the following command from the rails root directory:
```./run_app.sh```
