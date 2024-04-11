import 'package:flutter/material.dart';

import 'music_data.dart';
import 'user_data.dart';

class NewSongPage extends StatefulWidget {
  const NewSongPage({super.key});

  @override
  State<NewSongPage> createState() => _NewSongPageState();
}

class _NewSongPageState extends State<NewSongPage> {
  var statusIndex = 0;
  late Widget newSongStatus;

  @override
  Widget build(BuildContext context) {
    final artist = TextEditingController();
    final title = TextEditingController();
    //final label = TextEditingController();
    //final genre = TextEditingController();
    final releasedate = TextEditingController();
    final soundcloud = TextEditingController();

    switch (statusIndex) {
      //Submit Song Form
      case 0:
        newSongStatus = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: artist,
              decoration: const InputDecoration(
                hintText: 'Artist',
              ),
            ),
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            /*
            TextFormField(
              controller: label,
              decoration: const InputDecoration(
                hintText: 'Label ID',
              ),
            ),
            TextFormField(
              controller: genre,
              decoration: const InputDecoration(
                hintText: 'Genre ID',
              ),
            ),
            */
            TextFormField(
              controller: releasedate,
              decoration: const InputDecoration(
                hintText: 'Release Date (YYYY-MM-DD)',
              ),
            ),
            TextFormField(
              controller: soundcloud,
              decoration: const InputDecoration(
                hintText: 'SoundCloud Link',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  print('Submit clicked...');

                  try {
                    final status = await addSong(
                      artist.text,
                      title.text,
                      4, //int.tryParse(label.text),
                      3, //int.tryParse(genre.text),
                      provider.providerid,
                      releasedate.text,
                      soundcloud.text
                    );

                    print('Song sent...');

                    if (status == 201) {
                      setState(() {
                        statusIndex = 1;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error submitting song...")),
                      );
                    }
                  } catch (e) {
                      print("Failed to submit song: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to submit song: $e")),
                      );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        );

      //Submit Success
      case 1:
        newSongStatus = const Text('Song submitted successfully!');

      default:
        throw UnimplementedError();
    }

    return Center(
      child: newSongStatus,
    );
  }
}