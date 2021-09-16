#!/usr/bin/env sh

python manage.py migrate --no-input

python manage.py collectstatic --no-input

npm run build --prefix ./frontend

gunicorn django_settings.wsgi:application --bind 0.0.0.0:8000

