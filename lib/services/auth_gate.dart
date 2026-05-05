import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_game/screen/home/home_screen.dart';
import 'package:language_game/screen/home/login_screen.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/utils/platform_helper.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    // 💻 DESKTOP MODE (safe fallback)
    if (PlatformHelper.isDesktop) {
      user = null;
      UserSession.userId = "debug_user";

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return;
    }

    // 🔥 MOBILE / WEB MODE ONLY
    if (!PlatformHelper.isDesktop) {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        user = currentUser;
        UserSession.userId = currentUser.uid;

        try {
          await UserSession.loadFromFirebase();
        } catch (e) {
          debugPrint("UserSession load error: $e");
        }
      } else {
        user = null;
        UserSession.userId = null;
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⏳ LOADING
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ✅ LOGGED IN
    if (user != null) {
      return const HomeScreen();
    }

    // ❌ NOT LOGGED IN
    return const LoginScreen();
  }
}
