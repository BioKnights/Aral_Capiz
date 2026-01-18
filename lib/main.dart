import 'package:flutter/material.dart';

import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';
import 'screen/home_screen.dart';
import 'services/animated_background.dart';

import 'services/music_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔊 background music (safe, looped)
  await MusicService.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aral Capiz',

      initialRoute: '/login',

      routes: {
        '/login': (_) =>
            AnimatedBackground(child: const LoginScreen()),

        '/signup': (_) =>
            AnimatedBackground(child: const SignupScreen()),

        '/home': (_) =>
            AnimatedBackground(child: const HomeScreen()),
      },
    );
  }
}
