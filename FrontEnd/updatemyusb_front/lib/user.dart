// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var userIndex = 0;
  late Widget userAction;

  @override
  Widget build(BuildContext context) {
    switch (userIndex) {
      case 0:
        userAction = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print('login');
                setState(() {
                  userIndex = 1;
                });
              },
              child: const Text('Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print('create account');
              },
              child: const Text('Create Account'),
            ),
          ),
        ],
      );
      case 1:
        userAction = Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    setState(() {
                      userIndex = 0;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                left: 50.0,
                right: 50.0,
              ),
              child: Form(
                child: Column (
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        onPressed: () {print('logged in');},
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont have an account?'),
                TextButton(
                  onPressed: () {print('create an account');},
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        );
      default:
        throw UnimplementedError();
    }

    return Center(
      child: userAction,
    );
  }
}