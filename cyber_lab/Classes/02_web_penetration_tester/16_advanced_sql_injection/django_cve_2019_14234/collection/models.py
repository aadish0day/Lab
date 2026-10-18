from django.contrib.postgres.fields import JSONField
from django.db import models


class Collection(models.Model):
    name = models.CharField(max_length=128)
    detail = JSONField()

    def __str__(self):
        return self.name
