import 'package:http/http.dart' as http;
import 'dart:convert';

//Song APIs
Future<List<Song>> getSongs() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/music/songs/'));

  if (response.statusCode == 200) {
    List<Song> songs = [];
    for (var i = 0; i < jsonDecode(response.body).length; ++i) {
      songs.add(Song.fromJson(jsonDecode(response.body)[i] as Map<String, dynamic>));
    }
    return songs;
  } else {
    throw Exception('Failed to load songs');
  }
}

Future<List<Song>> getSavedSongs(djID) async {
  final response = await http.get(Uri.parse('http://localhost:8000/music/songs/saved/$djID/'));

  if (response.statusCode == 200) {
    List<Song> songs = [];
    for (var i = 0; i < jsonDecode(response.body).length; ++i) {
      songs.add(Song.fromJson(jsonDecode(response.body)[i] as Map<String, dynamic>));
    }
    return songs;
  } else {
    throw Exception('Failed to load songs');
  }
}

Future<int> saveSong(songID, djID) async {
  final response = await http.put(Uri.parse('http://localhost:8000/music/song/save/$songID/$djID/'));
  return response.statusCode;
}

Future<int> addSong(artist, title, int label, int genre, int provider, releasedate, soundcloud) async {
  var postBody = {
    'artist': artist,
    'title': title,
    'label': label,
    'genre': genre,
    'provider': provider,
    'releasedate': releasedate,
    'soundcloud': soundcloud,
  };

  final response = await http.post(
    Uri.parse('http://localhost:8000/music/songs/add/'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(postBody)
  );

  return response.statusCode;
}

//Label APIs
Future<List<Label>> getLabels() async {
  final response = await http.get(Uri.parse('http://localhost:8000/music/labels/'));

  if (response.statusCode == 200) {
    List<Label> labels = [];
    for (var i = 0; i < jsonDecode(response.body).length; ++i) {
      labels.add(Label.fromJson(jsonDecode(response.body)[i] as Map<String, dynamic>));
    }
    return labels;
  } else {
    throw Exception('Failed to load songs');
  }
}

//Genre APIs
Future<List<Genre>> getGenres() async {
  final response = await http.get(Uri.parse('http://localhost:8000/music/genres/'));

  if (response.statusCode == 200) {
    List<Genre> genres = [];
    for (var i = 0; i < jsonDecode(response.body).length; ++i) {
      genres.add(Genre.fromJson(jsonDecode(response.body)[i] as Map<String, dynamic>));
    }
    return genres;
  } else {
    throw Exception('Failed to load genres');
  }
}

//Data Classes
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

class Label {
  final int labelid;
  final String labelname;
  final String location;

  const Label({
    required this.labelid,
    required this.labelname,
    required this.location,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'labelid': int labelid,
        'labelname': String labelname,
        'location': String location,
      } => Label(
        labelid: labelid,
        labelname: labelname,
        location: location,
      ),
      _ => throw const FormatException('Failed to load labels'),
    };
  }
}

class Genre {
  final int genreid;
  final String genrename;

  const Genre({
    required this.genreid,
    required this.genrename,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'genreid': int genreid,
        'genrename': String genrename,
      } => Genre(
        genreid: genreid,
        genrename: genrename,
      ),
      _ => throw const FormatException('Failed to load genres'),
    };
  }
}