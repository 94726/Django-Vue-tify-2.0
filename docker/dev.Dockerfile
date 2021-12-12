FROM node:16-alpine as node

WORKDIR /frontend

COPY ./frontend/package.json .

RUN yarn install

COPY ./frontend/ .
CMD yarn serve

FROM python:3.9.6-slim-buster as django
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=django_settings.dev_settings

WORKDIR /code

RUN pip install --upgrade pip

COPY ./requirements.txt ./requirements.txt
RUN pip install -r ./requirements.txt

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
RUN chmod +x /wait

COPY . /code/

CMD bash -c '/wait && python manage.py migrate; python manage.py runserver 0.0.0.0:8000'