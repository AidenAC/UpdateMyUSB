import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpdateMyUSB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          'Update My USB',
          style: style,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.music_note_outlined,
                color: style.color,
              ),
              tooltip: 'New Music!',
              onPressed: () { }, 
            ),
            IconButton(
              icon: Icon(
                Icons.person_2_outlined,
                color: style.color,
              ),
              tooltip: 'User Profile',
              onPressed: () { }, 
            ),
          ],
      ),
      body: const Center(
        child: SongLink(),
      ),
    );
  }
}

class SongLink extends StatelessWidget {
  const SongLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface
    );

    return Link(
      target: LinkTarget.self,
      uri: Uri.parse('https://soundcloud.com/sub49records/fefo-electric-siren-saturday-night-fever'),
      builder: (context, followLink) => ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.surface),
        onPressed: followLink,
        child: Text(
          'Saturday Night Fever',
          style: style,
        ),
      ),
    );
  }
}