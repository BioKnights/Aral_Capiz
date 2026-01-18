import 'package:flutter/material.dart';
import 'package:language_game/services/auth_service.dart';
import 'package:language_game/services/user_session.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  String? _error;

  Future<void> _login() async {
    final u = _user.text.trim();
    final p = _pass.text.trim();

    if (u.isEmpty || p.isEmpty) {
      return setState(() => _error = "Please enter username and password");
    }

    if (await AuthService.loginUser(u, p)) {
      UserSession.login(u);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = "Wrong username or password");
    }
  }

  void _guest() {
    UserSession.guest();
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _goToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const RegisterScreen(),
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
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.25),
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

              _field("Username", _user),
              const SizedBox(height: 12),
              _field("Password", _pass, obscure: true),

              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login,
                child: const Text("ENTER"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _goToRegister,
                child: const Text("Create Account"),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: _guest,
                child: const Text(
                  "PLAY AS GUEST",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
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
      autofillHints:
          obscure ? [AutofillHints.password] : [AutofillHints.username],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
