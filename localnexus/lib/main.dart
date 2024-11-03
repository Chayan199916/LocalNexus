import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Nexus',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey[100], // Light background
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
