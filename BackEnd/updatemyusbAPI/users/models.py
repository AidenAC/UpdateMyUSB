from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.core.validators import MaxValueValidator, MinLengthValidator
from django.db import models

from .manager import USBUserManager

class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    fname = models.CharField(max_length=255, blank=True, default='')
    lname = models.CharField(max_length=255, blank=True, default='')
    location = models.CharField(max_length=255, blank=True, default='')

    is_dj = models.BooleanField(default=False)
    is_provider = models.BooleanField(default=False)

    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)

    objects = USBUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name = 'User'
        verbose_name_plural = 'Users'

    def __str__(self):
        return self.email
    
class DJ(models.Model):
    djid = models.AutoField(primary_key=True)
    email = models.ForeignKey(User, on_delete=models.CASCADE)
    djname = models.CharField(max_length=255, blank=False)

    def __str__(self):
        return self.djname
    
class MusicProvider(models.Model):
    providerid = models.AutoField(primary_key=True)
    email = models.ForeignKey(User, on_delete=models.CASCADE)
    providername = models.CharField(max_length=255, blank=False)

    #Provider can be one of 3 types:
    #   1 - Artist
    #   2 - Label
    #   3 - Promoter
    providertype = models.IntegerField(default=1, validators=[MaxValueValidator(3), MinLengthValidator(1)])

    def __str__(self):
        return self.providername