import 'package:flutter/material.dart';
import 'package:flutter_login/screens/home_screen.dart';
import 'package:flutter_login/screens/login.dart';
import 'package:flutter_login/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: LoginPage()
      // home: const SplashScreen()
    );
  }
}

