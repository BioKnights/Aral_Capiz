import 'package:flutter/material.dart';
import 'package:language_game/services/auth_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = "";

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => message = "Please complete all fields");
      return;
    }

    final success =
        await AuthService.registerUser(username, email, password);

    if (success) {
      UserSession.login(username);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => message = "Registration failed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Create Account"),
          backgroundColor: Colors.black54,
        ),
        body: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _field("Username", usernameController,
                    autofill: AutofillHints.username),
                _field("Email", emailController,
                    autofill: AutofillHints.email),
                _field("Password", passwordController,
                    obscure: true,
                    autofill: AutofillHints.newPassword),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: registerUser,
                  child: const Text("REGISTER"),
                ),

                if (message.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(message,
                      style: const TextStyle(color: Colors.white)),
                ],

                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text("Back to Login"),
                ),
              ],
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
    String? autofill,
  }) {
    return TextField(
      controller: c,
      obscureText: obscure,
      autofillHints: autofill != null ? [autofill] : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
