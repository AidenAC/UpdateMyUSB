from rest_framework import serializers
from .models import Song, Label, Genre

class SongSerializer(serializers.ModelSerializer):
    label = serializers.StringRelatedField()
    genre = serializers.StringRelatedField()
    provider = serializers.StringRelatedField()

    class Meta:
        model = Song
        #fields = '__all__'  #all shows djs that saved the song also
        fields = ['songid', 'label', 'genre', 'provider', 'artist', 'title', 'releasedate', 'soundcloud']

class LabelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Label
        fields = '__all__'

class GenreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Genre
        fields = '__all__'