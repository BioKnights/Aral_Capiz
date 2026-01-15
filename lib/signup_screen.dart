import 'package:flutter/material.dart';
import 'package:language_game/services/auth_service.dart';
import 'package:language_game/services/user_session.dart';
import 'animated_background.dart';

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

  void registerUser() async {
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
      // ✅ AUTO LOGIN
      UserSession.login(username);

      // ✅ GO TO HOME (NAMED ROUTE)
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        message = "Registration failed!";
      });
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
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: registerUser,
                  child: const Text("REGISTER"),
                ),

                const SizedBox(height: 10),

                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),

                TextButton(
                  child: const Text("Back to Login"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
