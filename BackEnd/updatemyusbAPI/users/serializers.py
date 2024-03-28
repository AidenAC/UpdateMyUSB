from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import User

class LoginSerializer(serializers.Serializer):
    email = serializers.CharField(label='email')
    password = serializers.CharField(label='password')
    
    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')

        if email and password:
            user = authenticate(email=email, password=password)
            if not user:
                raise serializers.ValidationError('Invalid Login', code='authentication')
        else:
            raise serializers.ValidationError('Email and Password required', code='authentication')
        
        attrs['user'] = user
        return attrs