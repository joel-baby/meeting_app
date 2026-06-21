import 'package:flutter/material.dart';
import 'package:meeting_app/screens/login_screen.dart';
import 'package:meeting_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting app',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {'/login': (context) => LoginScreen()},
    );
  }
}
