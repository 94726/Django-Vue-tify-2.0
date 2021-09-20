FROM nikolaik/python-nodejs:python3.9-nodejs16-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /code

RUN pip install --upgrade pip
COPY ./requirements.txt /code/requirements.txt

RUN pip install -r ./requirements.txt

COPY frontend/package.json /code/frontend/package.json

RUN npm install --prefix ./frontend

COPY . /code/

# FROM node:16 as node

# WORKDIR /code/frontend

# COPY ./frontend/ /code/frontend

# RUN npm install

# FROM python:3.9.6-slim-buster as django
# ENV PYTHONUNBUFFERED=1

# WORKDIR /code

# RUN pip install --upgrade pip
# COPY ./requirements.txt /code/requirements.txt

# RUN pip install -r ./requirements.txt