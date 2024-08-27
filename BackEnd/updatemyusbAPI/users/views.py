from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django.contrib.auth import login, logout
from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from .models import User, DJ, MusicProvider
from .serializers import LoginSerializer, UserSerializer, DJSerializer, MusicProviderSerializer

@api_view(['POST'])
def loginUser(request):
    serializer = LoginSerializer(data=request.data, context={ 'request': request })
    
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']
    login(request, user)

    try:
        token = Token.objects.get(user=request.user)
    except ObjectDoesNotExist:
        token = Token.objects.create(user=request.user)

    print(token) #ONLY USED FOR DEBUGGING

    userData = request.user
    userSerializer = UserSerializer(userData)

    return Response(userSerializer.data, status=status.HTTP_202_ACCEPTED)

#Unused in prototype
#@api_view(['GET'])
#def authCheck(request):
#    return JsonResponse({
#        "is_authenticated": request.user.is_authenticated
#    })

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUser(request):
    user = request.user
    serializer = UserSerializer(user)
    return Response(serializer.data)

@api_view(['GET'])
def getDJ(request, userID):
    dj = DJ.objects.get(email_id=userID)
    serializer = DJSerializer(dj)
    return Response(serializer.data)

@api_view(['GET'])
def getProvider(request, userID):
    provider = MusicProvider.objects.get(email_id=userID)
    serializer = MusicProviderSerializer(provider)
    return Response(serializer.data)

@api_view(['POST'])
def logoutUser(request):
    logout(request)
    token = request.headers.get('Authorization')[6:]
    Token.objects.get(pk=token).delete()
    return Response(None, status=status.HTTP_200_OK)
    