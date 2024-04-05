from django.db import models
from users.models import MusicProvider, DJ

class Label(models.Model):
    labelid = models.AutoField(primary_key=True)
    labelname = models.CharField(max_length=255, blank=False)
    location = models.CharField(max_length=255, blank=True)

    def __str__(self):
        return self.labelname
    
class Genre(models.Model):
    genreid = models.AutoField(primary_key=True)
    genrename = models.CharField(max_length=255, blank=False)

    def __str__(self):
        return self.genrename

class Song(models.Model):
    songid = models.AutoField(primary_key=True)
    artist = models.CharField(max_length=255, blank=False)
    title = models.CharField(max_length=255, blank=False)
    label = models.ForeignKey(Label, on_delete=models.CASCADE, blank=True, null=True)
    genre = models.ForeignKey(Genre, on_delete=models.CASCADE)
    provider = models.ForeignKey(MusicProvider, on_delete=models.CASCADE)
    releasedate = models.DateField(null=True)

    soundcloud = models.URLField(blank=True)

    djs = models.ManyToManyField(DJ, related_name='songs', blank=True)

    def __str__(self):
        return self.title