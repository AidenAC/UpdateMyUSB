import 'dart:convert';
import 'package:http/http.dart' as http;

late User user;
late DJ dj;
late Provider provider;
var auth = false;

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
    auth = true;

    if (user.isDJ) {loadDJ(user.id);}
    if (user.isProvider) {loadProvider(user.id);}
    
    print('login success');
  } else {
    print('login failed');
  }

  return response.statusCode;
}

loadDJ(id) async {
  var response = await http.get(Uri.parse('http://localhost:8000/users/dj/$id/'));
  dj = DJ.fromJson(jsonDecode(response.body));
}

loadProvider(id) async {
  var response = await http.get(Uri.parse('http://localhost:8000/users/provider/$id/'));
  provider = Provider.fromJson(jsonDecode(response.body));
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

class DJ {
  final int djid;
  final String email;
  final String djname;

  const DJ({
    required this.djid,
    required this.email,
    required this.djname,
  });

  factory DJ.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'djid': int djid,
        'email': String email,
        'djname': String djname,
      } => DJ(
        djid: djid,
        email: email,
        djname: djname,
      ),
      _ => throw const FormatException('Failed to load DJ'),
    };
  }
}

class Provider {
  final int providerid;
  final String email;
  final String providername;
  final int providertype;

  const Provider({
    required this.providerid,
    required this.email,
    required this.providername,
    required this.providertype,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'providerid': int providerid,
        'email': String email,
        'providername': String providername,
        'providertype': int providertype,
      } => Provider(
        providerid: providerid,
        email: email,
        providername: providername,
        providertype: providertype,
      ),
      _ => throw const FormatException('Failed to load Provider'),
    };
  }

  String getType() {
    switch(providertype) {
      case 1:
        return "Artist";
      case 2:
        return "Label";
      case 3:
        return "Promoter";
      default:
        return "Invalid Type";
    }
  }
}