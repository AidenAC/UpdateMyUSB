import 'package:http/http.dart' as http;

login(email, password) async {
  var response = await http.post(
    Uri.parse('http://127.0.0.1:8000/users/login/'),
    body: {
      "email" : email,
      "password": password
    }
  );
  
  print('email: $email, password: $password');
  if (response.statusCode == 202) {
    print('login success');
  } else {
    print('login failed');
  }
}