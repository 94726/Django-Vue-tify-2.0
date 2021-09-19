## Overview

### Development build
Uses docker-compose to start all needed services for development

Uses webpack (vue-cli) with 
<a href="https://pypi.org/project/django-webpack-loader/">django-webpack-loader</a>
to serve changes in the frontend to the backend and auto updating the webpage (hot-reload)

The docker-compose also runs postgres as database

### Production build
Uses docker-compose to start all needed services for production

Uses a multistage Dockerfile containing
- node environment to build the staticfiles needed for the vue frontend
- django environment to build the staticfiles needed for the django frontend
- nginx environment collecting the staticfiles to later serve them to the user

The docker-compose also runs postgres as database

## Usage

### Development (local environment)

#### Dependencies
- python 3.7 and up
- node

Install the python requirements by running
``pip install -r requirements``

Download node requirements by running
``npm install`` inside frontend

To start developing, run both
- ``python manage.py runserver``
- ``npm run serve`` in frontend

Now you should be able to connect to localhost:8000 and see a simple vue page

### Development (docker)

Run ``docker-compose up`` to start all services  
Now you should be able to connect to localhost:8000 and see a simple vue page

### Production

As this does not automatically update on changes, you may need to run  
``docker-compose -f docker-compose.prod.yml build``  
to build all the staticfiles

Run ``docker-compose -f docker-compose.prod.yml up`` to start the webpage

Alternatively use
``docker-compose -f docker-compose.prod.yml up --build``
to build and start the page at the same time

Now you should be able to connect to localhost:80 and see your page

## Note
The production build is only a template running nginx as reverse proxy for django and handling staticfiles
It is not completely ready for production from the get-go as you may want to
- add ssl-certificates to enable https
- change the login credentials for the postgres database
- add a better secret key for django
- ...

