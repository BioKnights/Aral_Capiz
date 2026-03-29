import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_game/screen/home/home_screen.dart';
import 'package:language_game/screen/home/login_screen.dart';
import 'package:language_game/services/user_session.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // ⏳ LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ LOGGED IN
        if (snapshot.hasData) {
          final user = snapshot.data!;

          // 🔥 SET USER ID HERE (IMPORTANT)
          UserSession.userId = user.uid;

          // 🔥 OPTIONAL (but recommended)
          UserSession.loadFromFirebase();

          return const HomeScreen();
        }

        // ❌ NOT LOGGED IN
        UserSession.userId = null; // 🔥 CLEAN RESET

        return const LoginScreen();
      },
    );
  }
}