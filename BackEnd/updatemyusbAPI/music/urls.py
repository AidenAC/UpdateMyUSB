from django.urls import path
from . import views

urlpatterns = [
    path('songs/', views.getSongs),
    path('songs/add/', views.addSong),
    path('song/save/<int:songid>/<int:djid>/', views.SaveSong),
    path('songs/saved/<int:djid>/', views.getSavedSongs),
    path('labels/', views.getLabels),
    path('labels/add/', views.addLabel),
    path('genres/', views.getGenres),
    path('genres/add', views.addGenre),
]