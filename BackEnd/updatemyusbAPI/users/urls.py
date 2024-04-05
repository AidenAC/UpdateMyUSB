from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.loginUser),
    path('check-auth/', views.authCheck),
    path('user/', views.getUser),
    path('dj/<int:userID>/', views.getDJ),
]