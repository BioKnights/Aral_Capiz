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
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 ADD THIS

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 INIT ADS
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  // 🔥 INIT FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 FORCE LOGOUT (FIX AUTO LOGIN)
  await FirebaseAuth.instance.signOut();

  // 🔥 LOAD LOCAL SESSION
  await UserSession.load();

  // 🔥 LOCK PORTRAIT
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 🔥 INIT MUSIC
  await MusicService.init();

  runApp(const MyApp());
}

// 🔥 NOW STATEFUL (for lifecycle control)
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

    // 🔥 ENSURE MUSIC START ONLY ONCE
    if (!MusicService.isPlaying) {
      MusicService.start();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 🔥 APP LIFECYCLE CONTROL
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      MusicService.pause(); // 🔇 minimize
    } else if (state == AppLifecycleState.resumed) {
      MusicService.resume(); // 🔊 balik open
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),

      // 🔥 START WITH SPLASH
      home: const SplashScreen(),

      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}