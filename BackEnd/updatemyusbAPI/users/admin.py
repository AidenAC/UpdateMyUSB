from django.contrib import admin
from django.contrib.auth.models import Group
from .models import User, DJ, MusicProvider

admin.site.register(User)
admin.site.register(DJ)
admin.site.register(MusicProvider)

admin.site.unregister(Group)