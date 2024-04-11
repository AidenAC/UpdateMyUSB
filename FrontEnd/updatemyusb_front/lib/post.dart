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

  late Future<List<Label>> labels;
  late Future<List<Genre>> genres;

  @override
  void initState() {
    super.initState();

    labels = getLabels();
    genres = getGenres();
  }

  @override
  Widget build(BuildContext context) {
    final artist = TextEditingController();
    final title = TextEditingController();
    late Label label;
    late Genre genre;
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
            Row(
              children: [
                FutureBuilder<List<Label>>(
                  future: labels,
                  builder: (context, snapshot) {
                    return MenuAnchor(
                      builder: (BuildContext context, MenuController controller,Widget? child) {
                        return TextButton(
                          onPressed: () {
                            if (controller.isOpen){
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: const Text('Label'),
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        snapshot.data!.length, 
                        (index) => MenuItemButton(
                          onPressed: () {
                            label = snapshot.data!.elementAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${label.labelname} selected.")),
                            );
                          },
                          child: Text(snapshot.data!.elementAt(index).labelname),
                        ),
                      ),
                    );
                  }
                ),
                FutureBuilder<List<Genre>>(
                  future: genres,
                  builder: (context, snapshot) {
                    return MenuAnchor(
                      builder: (BuildContext context, MenuController controller,Widget? child) {
                        return TextButton(
                          onPressed: () {
                            if (controller.isOpen){
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: const Text('Genre'),
                        );
                      },
                      menuChildren: List<MenuItemButton>.generate(
                        snapshot.data!.length, 
                        (index) => MenuItemButton(
                          onPressed: () {
                            genre = snapshot.data!.elementAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${genre.genrename} selected.")),
                            );
                          },
                          child: Text(snapshot.data!.elementAt(index).genrename),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
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
                  final status = await addSong(
                    artist.text,
                    title.text,
                    label.labelid,
                    genre.genreid,
                    provider.providerid,
                    releasedate.text,
                    soundcloud.text
                  );

                  if (status == 201) {
                    setState(() {
                      statusIndex = 1;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Error submitting song...")),
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