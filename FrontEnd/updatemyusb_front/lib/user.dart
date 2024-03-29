// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'user_data.dart';

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
      //Use Case: User not authenticated
      case 0:
        userAction = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
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
                setState(() {
                  userIndex = 2;
                });
              },
              child: const Text('Create Account'),
            ),
          ),
        ],
      );

      //Use Case: User loggs in existing account
      case 1:
        final email = TextEditingController();
        final password = TextEditingController();
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
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final auth = await login(email.text, password.text);

                          if (auth == 202) {
                            setState(() {
                              userIndex = 3;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error logging in, try again...")),
                            );
                          }
                        },
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
                  onPressed: () {
                    setState(() {
                      userIndex = 2;
                    });
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        );

      //Use Case: User creates new account
      case 2:
        userAction = Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    setState(() {
                      userIndex = 0;
                    });
                  }
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sign up as a...'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {print('dj');},
                          child: const Text('DJ'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {print('music provider');},
                          child: const Text('Music Provider'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          print('login');
                          setState(() {
                            userIndex = 1;
                          });
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );

        case 3:
        userAction = const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged in successfully!"),
            Text("Let's find new music..."),
          ]
        );

      //Unreachable index error
      default:
        throw UnimplementedError();
    }

    return Center(
      child: userAction,
    );
  }
}