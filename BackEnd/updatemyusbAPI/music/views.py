from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import SongSerializer, CreateSongSerializer, LabelSerializer, GenreSerializer
from .models import Song, Label, Genre
from users.models import DJ

#Song Views
@api_view(['GET'])
def getSongs(request):
    songs = Song.objects.all()
    serializer = SongSerializer(songs, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getSavedSongs(request, djid):
    songs = Song.objects.filter(djs=djid)
    serializer = SongSerializer(songs, many=True)
    return Response(serializer.data)

@api_view(['PUT'])
def SaveSong(request, songid, djid):
    song = Song.objects.get(pk=songid)
    dj = DJ.objects.get(pk=djid)

    if song.djs.contains(dj):
        return Response(None, status=status.HTTP_208_ALREADY_REPORTED)
    else:
        song.djs.add(djid)
        return Response(None, status=status.HTTP_200_OK)

@api_view(['POST'])
def addSong(request):
    serializer = CreateSongSerializer(data=request.data, context={ 'request': request })
    serializer.is_valid(raise_exception=True)
    serializer.save()
    return Response(None, status=status.HTTP_201_CREATED)

#Label Views
@api_view(['GET'])
def getLabels(request):
    labels = Label.objects.all()
    serializer = LabelSerializer(labels, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def addLabel(request):
    serializer = LabelSerializer(data=request.data, context={ 'request': request })
    serializer.is_valid(raise_exception=True)
    serializer.save()
    return Response(None, status=status.HTTP_201_CREATED)

#Genre Views
@api_view(['GET'])
def getGenres(request):
    genres = Genre.objects.all()
    serializer = GenreSerializer(genres, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def addGenre(request):
    serializer = GenreSerializer(data=request.data, context={ 'request': request })
    serializer.is_valid(raise_exception=True)
    serializer.save()
    return Response(None, status=status.HTTP_201_CREATED)