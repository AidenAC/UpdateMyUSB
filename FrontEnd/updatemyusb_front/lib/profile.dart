import 'package:flutter/material.dart';

import 'user_data.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${user.fname} ${user.lname}'),
        Text('Email: ${user.email}'),
        Text('Location: ${user.location}'),

        Visibility(
          visible: user.isDJ,
          child: Text('DJ Name: ${dj.djname}'),
        ),
      ],
    );
  }
}