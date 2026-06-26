import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/resources/auth_methods.dart';
import 'package:meeting_app/screens/home_screen.dart';
import 'package:meeting_app/screens/login_screen.dart';
import 'package:meeting_app/screens/schedule_screen.dart';
import 'package:meeting_app/screens/share_screen.dart';
import 'package:meeting_app/screens/video_call_screen.dart';
import 'package:meeting_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // All three are created ONCE so the StreamBuilder builder never hands Flutter
  // a new widget instance on auth re-emissions (token refresh, app resume, etc.).
  // If these were constructed inside the builder, Flutter would tear down and
  // remount HomeScreen on every Firebase auth event, resetting all state.
  late final Stream _authStream = AuthMethods().authChanges;
  final _homeScreen = const HomeScreen();
  final _loginScreen = const LoginScreen();
  final _loading = const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting app',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: _authStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loading;
          }
          if (snapshot.hasData) {
            return _homeScreen;
          }
          return _loginScreen;
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/share': (context) => const ShareScreen(),
      },
    );
  }
}