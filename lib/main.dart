import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'animated_background.dart';
import 'package:language_game/services/user_session.dart';
import 'services/music_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ SAFE FOR ALL PLATFORMS
  await MusicService.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Game',

      initialRoute: '/login',

      routes: {
        '/login': (_) =>
            AnimatedBackground(child: const LoginScreen()),

        '/signup': (_) =>
            AnimatedBackground(child: const SignupScreen()),

        '/home': (_) =>
            AnimatedBackground(child: HomeScreen(UserSession())),
      },
    );
  }
}
