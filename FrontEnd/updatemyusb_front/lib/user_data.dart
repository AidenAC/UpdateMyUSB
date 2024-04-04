import 'dart:convert';
import 'package:http/http.dart' as http;

var user;

Future<int> login(email, password) async {
  var response = await http.post(
    Uri.parse('http://127.0.0.1:8000/users/login/'),
    body: {
      "email" : email,
      "password": password
    }
  );
  
  print('email: $email, password: $password');
  if (response.statusCode == 202) {
    //If login success save user to session
    user = User.fromJson(jsonDecode(response.body));
    print('login success');
  } else {
    print('login failed');
  }

  return response.statusCode;
}

//Debug: Unused functions and classes to test auth
/*
Future<User> userAuth() async {
  var response = await http.get(Uri.parse('http://localhost:8000/users/user/'));
  final userData = User.fromJson(jsonDecode(response.body));
  return userData;
}

Future<bool> checkAuth() async {
  final response = await http.get(Uri.parse('http://localhost:8000/users/check-auth/'));
  UserAuth data = UserAuth.fromJson(jsonDecode(response.body));
  final auth = data.isAuthenticated;

  print(auth);
  return auth;
}

class UserAuth {
  final bool isAuthenticated;

  const UserAuth({required this.isAuthenticated});

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'is_authenticated': bool isAuthenticated,
      } => UserAuth(isAuthenticated: isAuthenticated,),
      _ => throw const FormatException('Failed get user authentication'),
    };
  }
}
*/

class User {
  final int id;
  final String email;
  final String fname;
  final String lname;
  final String location;
  final bool isDJ;
  final bool isProvider;

  const User({
    required this.id,
    required this.email,
    required this.fname,
    required this.lname,
    required this.location,
    required this.isDJ,
    required this.isProvider,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': int id,
        'email': String email,
        'fname': String fname,
        'lname': String lname,
        'location': String location,
        'is_dj': bool isDJ,
        'is_provider': bool isProvider,
      } => User(
        id: id,
        email: email,
        fname: fname,
        lname: lname,
        location: location,
        isDJ: isDJ,
        isProvider: isProvider,
      ),
      _ => throw const FormatException('Failed to load user'),
    };
  }
}