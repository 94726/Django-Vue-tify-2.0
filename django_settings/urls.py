"""django_webpack URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.urls import path
from django.views.generic import TemplateView
from django.conf.urls.static import static
from django_settings.base_settings import MEDIA_URL, MEDIA_ROOT


# Add new urls above the index.html TemplateViews


urlpatterns = [
    path('admin/', admin.site.urls),
    *static(MEDIA_URL, document_root=MEDIA_ROOT), # for development
    url(r'', TemplateView.as_view(template_name='index.html')),
]