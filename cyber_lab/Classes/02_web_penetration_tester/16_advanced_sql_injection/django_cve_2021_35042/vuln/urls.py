from django.urls import path

from . import views

urlpatterns = [
    path("", views.vul),
    path("vuln/", views.vul),
]
