from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.db import models

from .manager import USBUserManager

class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    fname = models.CharField(max_length=255, blank=True, default='')
    lname = models.CharField(max_length=255, blank=True, default='')
    location = models.CharField(max_length=255, blank=True, default='')

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