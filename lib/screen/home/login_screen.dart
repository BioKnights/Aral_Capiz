import 'package:flutter/material.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/auth_service.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String? _error;
  bool _loading = false;

  // ================= EMAIL LOGIN =================
  Future<void> _login() async {
    final email = _email.text.trim();
    final password = _pass.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = "Please enter email and password");
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    final success = await AuthService.loginUser(email, password);

    if (!mounted) return;

    if (success) {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        UserSession.userId = firebaseUser.uid;
        await UserSession.loadFromFirebase();
      }

      await UserSession.syncToFirebase();

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _error = "Invalid email or password";
        _loading = false;
      });
    }
  }

  // ================= GOOGLE LOGIN =================
  Future<void> _googleLogin() async {
    final success = await AuthService.signInWithGoogle();

    if (!mounted) return;

    if (success) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        UserSession.userId = user.uid;
        await UserSession.loadFromFirebase();
      }

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  // ================= GUEST =================
  void _guest() {
    UserSession.guest();
    UserSession.userId = null;
    Navigator.pushReplacementNamed(context, '/home');
  }

  // ================= NAVIGATE REGISTER =================
  void _goToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignupScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Container(
              width: 360,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _field("Email", _email),
                  const SizedBox(height: 12),
                  _field("Password", _pass, obscure: true),

                  if (_error != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // 🔥 EMAIL LOGIN
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _login,
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("ENTER"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔥 GOOGLE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _googleLogin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 22,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔥 FACEBOOK BUTTON (UI only)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1877F2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Facebook login soon 🚀"),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 22,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Continue with Facebook",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToRegister,
                      child: const Text("CREATE ACCOUNT"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: _guest,
                    child: const Text(
                      "PLAY AS GUEST",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController c, {
    bool obscure = false,
  }) {
    return TextField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}