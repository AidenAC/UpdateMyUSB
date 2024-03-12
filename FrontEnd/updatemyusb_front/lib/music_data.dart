import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Song>> getSongs() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/music/songs/'));

  if (response.statusCode == 200) {
    List<Song> songs = [];
    for (var i = 0; i < jsonDecode(response.body).length; ++i) {
      songs.add(Song.fromJson(jsonDecode(response.body)[i] as Map<String, dynamic>));
    }
    return songs;
  } else {
    throw Exception('Failed to load song');
  }
}

class Song {
  final int songid;
  final String label;
  final String genre;
  final String provider;
  final String artist;
  final String title;
  final String releasedate;
  final String soundcloud;

  const Song({
    required this.songid,
    required this.label,
    required this.genre,
    required this.provider,
    required this.artist,
    required this.title,
    required this.releasedate,
    required this.soundcloud,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    
    return switch (json) {
      {
        'songid': int songid,
        'label': String label?,
        'genre': String genre,
        'provider': String provider,
        'artist': String artist,
        'title': String title,
        'releasedate': String releasedate,
        'soundcloud': String soundcloud,
      } => Song(
          songid: songid,
          label: label,
          genre: genre,
          provider: provider,
          artist: artist,
          title: title,
          releasedate: releasedate,
          soundcloud: soundcloud,
        ),
      _ => throw const FormatException('Failed to load songs'),
    };
  }
}