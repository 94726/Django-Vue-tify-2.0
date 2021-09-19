FROM node:16-alpine as node

WORKDIR /frontend

COPY ./frontend/ .

RUN npm install

RUN npm run build

FROM python:3.9.6-slim-buster as django
ENV PYTHONUNBUFFERED=1

WORKDIR /code

RUN pip install --upgrade pip

COPY /requirements.txt /code/requirements.txt
COPY /apps ./apps/
COPY /django_settings ./django_settings/
COPY /templates ./templates/
COPY /manage.py .

RUN pip install -r ./requirements.txt

RUN python manage.py migrate --no-input
RUN python manage.py collectstatic --no-input

COPY --from=node /frontend/build/templates ./templates/
COPY --from=node /frontend/build/dist ./staticfiles/dist/

FROM nginx:alpine as nginx

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=django /code/staticfiles /staticfiles


#COPY . /code/
