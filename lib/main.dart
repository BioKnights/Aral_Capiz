import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_game/screen/home/splash_screen.dart';
import 'package:language_game/screen/home/login_screen.dart';
import 'package:language_game/screen/home/signup_screen.dart';
import 'package:language_game/screen/home/home_screen.dart';
import 'services/music_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:language_game/services/user_session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_game/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 INIT ADS (mobile only)
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  // 🔥 INIT FIREBASE
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized");
  } catch (e) {
    print("🔥 Firebase init error: $e");
  }

  // 🔥 LOAD LOCAL SESSION
  await UserSession.load();

  // 🔥 LOCK PORTRAIT
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 🔥 INIT MUSIC
  try {
    await MusicService.init();
  } catch (e) {
    print("Music init error: $e");
  }

  runApp(const MyApp());
}

// 🔥 APP ROOT
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    try {
      if (!MusicService.isPlaying) {
        MusicService.start();
      }
    } catch (e) {
      print("Music start error: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 🔥 MUSIC CONTROL
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      if (state == AppLifecycleState.paused) {
        MusicService.pause();
      } else if (state == AppLifecycleState.resumed) {
        MusicService.resume();
      }
    } catch (e) {
      print("Lifecycle music error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),

      // 🔥 AUTH STREAM (USING AUTH SERVICE)
      home: StreamBuilder<User?>(
        stream: AuthService.authStateChanges,
        builder: (context, snapshot) {
          // ⏳ LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          // ✅ LOGGED IN
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // ❌ NOT LOGGED IN
          return const LoginScreen();
        },
      ),

      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
