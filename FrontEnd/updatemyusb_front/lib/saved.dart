import 'package:flutter/material.dart';

import 'music_data.dart';
import 'user_data.dart';

import 'music.dart';

class SavedSongsPage extends StatefulWidget {
  const SavedSongsPage({super.key});

  @override
  State<SavedSongsPage> createState() => _SavedSongsPageState();
}

class _SavedSongsPageState extends State<SavedSongsPage> {
  late Future<List<Song>> songs;
  
  @override
  void initState() {
    super.initState();

    songs = getSavedSongs(dj.djid);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Song>>(
        future: songs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.isEmpty) {
              return const Text('Start saving some songs!');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.all(5),
                    child: SongLink(
                      snapshot.data!.elementAt(index).songid,
                      snapshot.data!.elementAt(index).soundcloud,
                      snapshot.data!.elementAt(index).title,
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}