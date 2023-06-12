# Documentation for MyBroker Insurance Project

## Overview
The MyBroker Insurance project is a web-based application that aims to provide insurance brokerage services to users. It consists of two main components: a Rails backend for managing data and business logic, and a Vue.js frontend for user interaction. The project is deployed on Google Cloud Platform (GCP), with the Rails backend hosted on Cloud Run and the Vue.js frontend hosted on App Engine.

### Deployment Details
The production version of the project can be accessed at the following URL: https://mybrokerinsurance.ew.r.appspot.com/. The Rails backend is deployed on Cloud Run and uses a PostgreSQL database. The Vue.js frontend is hosted on App Engine. For learning about Rails deployment on GCP, please see this https://cloud.google.com/ruby/rails/run

### Environment Variables
The Rails backend relies on environment variables for configuration. These variables are loaded from a .env file in the production environment. It is essential to ensure that the required variables are properly set before deploying the application. Please refer to the .env file for the specific environment variables and their values.

### Rails Backend
The Rails backend of the MyBroker Insurance project handles data management and implements the core business logic. It utilizes PostgreSQL as the database management system. The backend includes the following key components:

Models: The backend includes RSpec tests for the Subscriber and RequestedQuote models. These tests ensure the reliability and correctness of the data models.

Object Services: The services folder contains two key services:

a. handle_subscriber: This service is responsible for updating or adding new subscribers to the system. It ensures that the subscriber data is accurate and up to date.

b. quote_generator: This service contacts an external API service using an API key in the header. It generates insurance quotes based on the user's input and sends an email containing the quote to the subscriber. Additionally, it generates a PDF attachment for the quote.

### Vue.js Frontend
The Vue.js frontend of the MyBroker Insurance project provides a user-friendly interface for interacting with the application. The primary goals of the frontend are:

1. User Contact: The frontend allows users to provide their contact information, with a minimum requirement of an email address. This information enables the system to communicate with the user effectively.

2. Quote Request: Users can request insurance quotes for different covers. The frontend collects the necessary information and sends it to the backend for processing. The quote generator service in the Rails backend handles this request and communicates with the external API to generate the quote.

# Local Development Environment
To set up the local development environment for the MyBroker Insurance project, follow the steps below:

## Rails Backend (mybroker-service folder):

In the root folder of the Rails project (mybroker-service), run the **./run_app.sh** script. This script sets up the necessary dependencies and starts the Rails server for local development.

## Vue.js Frontend (mybroker-frontend folder):

Set up the Vue.js project dependencies using a package manager npm. Run npm install, and
start the local development server using the command **npm run serve**.
Please refer to the project's documentation or README file for more detailed instructions on setting up the local development environment.

## Conclusion
The MyBroker Insurance project combines the power of Rails backend and Vue.js frontend to provide a comprehensive insurance brokerage solution. The Rails backend manages the data and implements the business logic, while the Vue.js frontend offers an intuitive user interface. By deploying the project on Google Cloud Platform, it leverages the scalability and reliability of GCP services.
