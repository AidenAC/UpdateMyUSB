from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import SongSerializer
from .models import Song

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
    song.djs.add(djid)
    return Response(None, status=status.HTTP_200_OK)