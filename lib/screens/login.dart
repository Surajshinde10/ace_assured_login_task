import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                login(emailController.text, passwordController.text);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Login Successfully'),
                //     duration: Duration(seconds: 3),
                //   ),
                // );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> login(String email, String password) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://medusa-production-d0a5.up.railway.app/store/auth/token/'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'email': email,
  //         'password': password,
  //       }),
  //     );
  //
  //     print('Login Response Status Code: ${response.statusCode}');
  //     print('Login Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       final String accessToken = data['access_token'];
  //
  //       await saveBearerToken(accessToken);
  //
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomePage()),
  //       );
  //     } else {
  //       throw Exception('Invalid credentials');
  //     }
  //   } catch (error) {
  //     print('Error during login: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(${response.body}'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://medusa-production-d0a5.up.railway.app/store/auth/token/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Login Response Status Code: ${response.statusCode}');
    print('Login Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String accessToken = data['access_token'];

      await saveBearerToken(accessToken);

      print('Before navigation');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      print('After navigation');
    } else {
      print('Error during login');
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> saveBearerToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }
}
