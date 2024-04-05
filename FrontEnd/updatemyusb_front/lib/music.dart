import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import 'music_data.dart';

class MusicPage extends StatelessWidget {
  late final Future<List<Song>> songs;

  MusicPage(this.songs, {super.key}) {
    super.key;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Song>>(
        future: songs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  child: SongLink(
                    snapshot.data!.elementAt(index).soundcloud,
                    snapshot.data!.elementAt(index).title,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}

class SongLink extends StatelessWidget {
  late final String link;
  late final String title;

  SongLink(this.link, this.title, {super.key}) {
    super.key;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface
    );

    return Row(
      children: [
        Link(
          target: LinkTarget.self,
          uri: Uri.parse(link),
          builder: (context, followLink) => ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.surface),
            onPressed: followLink,
            child: Text(
              title,
              style: style,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.bookmark_add_outlined),
          tooltip: 'Save!',
        ),
      ],
    );
  }
}