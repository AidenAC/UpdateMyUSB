from django.urls import path
from . import views

urlpatterns = [
    path('songs/', views.getSongs),
    path('songs/add/', views.addSong),
    path('songs/saved/<int:djid>/', views.getSavedSongs),
    path('song/save/<int:songid>/<int:djid>/', views.SaveSong),
    path('labels/', views.getLabels),
    path('genres/', views.getGenres),
]