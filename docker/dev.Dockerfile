FROM nikolaik/python-nodejs:python3.9-nodejs16-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /code

RUN pip install --upgrade pip
COPY ./requirements.txt /code/requirements.txt

RUN pip install -r ./requirements.txt

COPY frontend/package.json /code/frontend/package.json

RUN npm install --prefix ./frontend

COPY . /code/