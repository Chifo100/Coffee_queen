from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Coffee, Comment

admin.site.register(Coffee)
admin.site.register(Comment)
