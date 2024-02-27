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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          'Update My USB',
          style: style,
          ),
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