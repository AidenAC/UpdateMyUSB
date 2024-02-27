from django.contrib import admin
from .models import Label, Genre, Song

admin.site.register(Label)
admin.site.register(Genre)
admin.site.register(Song)