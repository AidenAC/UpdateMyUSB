from rest_framework import serializers
from .models import Song, Label, Genre
from users.models import MusicProvider

class SongSerializer(serializers.ModelSerializer):
    label = serializers.StringRelatedField(label='label')
    genre = serializers.StringRelatedField(label='genre')
    provider = serializers.StringRelatedField(label='provider')

    class Meta:
        model = Song
        #fields = '__all__'  #all shows djs that saved the song also
        fields = ['songid', 'label', 'genre', 'provider', 'artist', 'title', 'releasedate', 'soundcloud']

class CreateSongSerializer(serializers.Serializer):
    artist = serializers.CharField(label='artist')
    title = serializers.CharField(label='title')
    genre = serializers.IntegerField(label='genre')
    label = serializers.IntegerField(label='label')
    provider = serializers.IntegerField(label='provider')
    releasedate = serializers.DateField(label='releasedate')
    soundcloud = serializers.URLField(label='soundcloud', allow_blank=False)

    def validate(self, attrs):
        genre = attrs.get('genre')
        label = attrs.get('label')
        provider = attrs.get('provider')

        if not Genre.objects.filter(pk=genre).exists():
            raise serializers.ValidationError('Select a valid genre', code=409)

        if not Label.objects.filter(pk=label).exists():
            raise serializers.ValidationError('Select a valid label', code=409)
        
        if not MusicProvider.objects.filter(pk=provider).exists():
            raise serializers.ValidationError('Select a valid provider', code=409)
        
        attrs['genre'] = Genre.objects.get(pk=genre)
        attrs['label'] = Label.objects.get(pk=label)
        attrs['provider'] = MusicProvider.objects.get(pk=provider)

        return attrs
    
    def create(self, validated_data):
        return Song.objects.create(**validated_data)
    
    #View serializer for testing
    #class Meta:
    #    fields = '__all__'

class LabelSerializer(serializers.ModelSerializer):
    labelname = serializers.CharField(label='labelname')
    location = serializers.CharField(label='location', allow_blank=True)

    def create(self, validated_data):
        return Label.objects.create(**validated_data)

    class Meta:
        model = Label
        fields = '__all__'

class GenreSerializer(serializers.ModelSerializer):
    genrename = serializers.CharField(label='genrename')

    def create(self, validated_data):
        return Genre.objects.create(**validated_data)

    class Meta:
        model = Genre
        fields = '__all__'