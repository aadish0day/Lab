#!/usr/bin/env python3
import os
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", __name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DEBUG = True
SECRET_KEY = "__secret_key__"
ALLOWED_HOSTS = ["*"]
ROOT_URLCONF = __name__

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "collection",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.environ.get("POSTGRES_DB", "django"),
        "USER": os.environ.get("POSTGRES_USER", "postgres"),
        "PASSWORD": os.environ.get("POSTGRES_PASSWORD", "postgres"),
        "HOST": os.environ.get("POSTGRES_HOST", "db"),
        "PORT": "5432",
    }
}

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    }
]

STATIC_URL = "/static/"

import django

django.setup()

from django.contrib import admin
from django.shortcuts import redirect
from django.urls import path


def redirect_to_collection(request):
    query = request.META.get("QUERY_STRING", "")
    url = "/admin/collection/collection/"
    if query:
        url += "?" + query
    return redirect(url)


def admin_root_view(request):
    if request.user.is_authenticated and request.user.is_staff:
        return admin.site.index(request)
    return admin.site.login(request)


urlpatterns = [
    path("admin/vuln/collection/", redirect_to_collection),
    path("admin/", admin_root_view),
    path("admin/", admin.site.urls),
]

from django.core.management import execute_from_command_line

if __name__ == "__main__":
    execute_from_command_line(sys.argv)
