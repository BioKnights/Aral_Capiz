import 'package:flutter/material.dart';
import 'package:language_game/services/auth_service.dart';
import 'package:language_game/services/user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  String? error;

  void login() async {
    final username = _userController.text.trim();
    final password = _passController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => error = "Please enter username and password");
      return;
    }

    final success = await AuthService.loginUser(username, password);

    if (success) {
      UserSession.login(username);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        error = "Wrong username or password";
      });
    }
  }

  void playAsGuest() {
    UserSession.guest();
    Navigator.pushReplacementNamed(context, '/home');
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
            color: Colors.black.withOpacity(0.25),
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

              TextField(
                controller: _userController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _passController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              if (error != null) ...[
                const SizedBox(height: 10),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: const Text("ENTER"),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Create Account"),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: playAsGuest,
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
}
