from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth import login
from django.http import JsonResponse
from .models import User
from .serializers import LoginSerializer

@api_view(['POST'])
def loginUser(request):
    serializer = LoginSerializer(data=request.data, context={ 'request': request })
    
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']
    login(request, user)
    return Response(None, status=status.HTTP_202_ACCEPTED)


@api_view(['GET'])
def authCheck(request):
    return JsonResponse({
        "is_authenticated": request.user.is_authenticated
    })