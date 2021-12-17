FROM node:16-alpine as node
ENV NODE_ENV=production

WORKDIR /frontend

COPY ./frontend/package.json .

RUN yarn install

COPY ./frontend/ .
RUN yarn build

FROM python:3.9.6-slim-buster as django
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=django_settings.prod_settings

WORKDIR /code

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
RUN chmod +x /wait

RUN pip install --upgrade pip

COPY ./requirements.txt ./requirements.txt
RUN pip install -r ./requirements.txt


COPY /apps ./apps/
COPY /django_settings ./django_settings/
COPY /templates ./templates/
COPY /manage.py .

RUN python manage.py collectstatic --no-input

COPY --from=node /frontend/build/templates ./templates
COPY --from=node /frontend/build/dist /staticfiles/dist

CMD bash -c '/wait && python manage.py migrate; gunicorn django_settings.wsgi:application --bind 0.0.0.0:8000'