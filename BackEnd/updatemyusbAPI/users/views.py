from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth import authenticate, login
from .models import User
from .serializers import LoginSerializer

@api_view(['POST'])
def loginUser(request):
    serializer = LoginSerializer(data=request.data, context={ 'request': request })
    
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']
    login(request, user)
    return Response(None, status=status.HTTP_202_ACCEPTED)
