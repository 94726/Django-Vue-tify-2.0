from .base_settings import *

STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
DEBUG = 0

CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
SECURE_SSL_REDIRECT = False  # setup ssl for secure production
SECURE_HSTS_SECONDS = 300  # set low, but when site is ready for deployment, set to at least 15768000 (6 months)
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True
