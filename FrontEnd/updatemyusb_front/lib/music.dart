import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SongLink(),
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