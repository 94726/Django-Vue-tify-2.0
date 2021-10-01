FROM node:16-alpine as node_installation

WORKDIR /frontend

COPY ./frontend/package.json .

RUN yarn install

FROM node_installation as node

COPY ./frontend/ .
RUN yarn build

FROM python:3.9.6-slim-buster as django
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=django_settings.prod_settings

WORKDIR /code

RUN pip install --upgrade pip
COPY ./requirements.txt ./requirements.txt
COPY /apps ./apps/
COPY /django_settings ./django_settings/
COPY /templates ./templates/
COPY /manage.py .

RUN pip install -r ./requirements.txt

RUN python manage.py migrate --no-input
RUN python manage.py collectstatic --no-input

COPY --from=node /frontend/build/templates ./templates
COPY --from=node /frontend/build/dist ./staticfiles/dist

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
RUN chmod +x /wait

# for use with django channels
# CMD bash -c '/wait && daphne django_settings.asgi:application -b 0.0.0.0 -p 8000'

CMD bash -c '/wait && gunicorn django_settings.wsgi:application --bind 0.0.0.0:8000'

FROM nginx:alpine as nginx

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=django /code/staticfiles /staticfiles