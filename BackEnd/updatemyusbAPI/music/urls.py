from django.urls import path
from . import views

urlpatterns = [
    path('songs/', views.getSongs),
    path('songs/saved/<int:djid>/', views.getSavedSongs),
    path('song/save/<int:songid>/<int:djid>/', views.SaveSong),
]