from django.urls import path
from rest_framework.authtoken import views as tokenViews
from . import views

urlpatterns = [
    path('login/', views.loginUser),
    path('token/', tokenViews.obtain_auth_token), #user must also obtain token through POST
    #path('check-auth/', views.authCheck),
    path('user/', views.getUser), #this endpoint is used to check users in with sessions
    path('dj/<int:userID>/', views.getDJ),
    path('provider/<int:userID>/', views.getProvider),
]

## NOTICE ##
# 'token/ path must be accessed through POST with body:
# {
# "username": "",
#  "password": ""
# }