import 'package:flutter/material.dart';

import 'music.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    Widget page;
    switch (pageIndex) {
      case 0:
        page = MusicPage();
      case 1:
        page = Placeholder();
      default:
        throw UnimplementedError('no page for $pageIndex');
    }

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
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              }, 
            ),
            IconButton(
              icon: Icon(
                Icons.person_2_outlined,
                color: style.color,
              ),
              tooltip: 'User Profile',
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              }, 
            ),
          ],
      ),
      body: Container(
        child: Center(
          child: page,
        ),
      ),
    );
  }
}