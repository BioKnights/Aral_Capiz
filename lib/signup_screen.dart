import 'package:flutter/material.dart';
import 'package:language_game/services/auth_service.dart';
import 'login_screen.dart';
import 'animated_background.dart';   // ← LIVE WALLPAPER

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
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => message = "Please complete all fields");
      return;
    }

    final success =
        await AuthService.registerUser(username, email, password);

    setState(() {
      if (success) {
        message = "Registration successful!";
      } else {
        message = "Registration failed!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(        // ← LIVE WALLPAPER WRAPPER
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Create Account"),
          backgroundColor: const Color(0xFF3C6E71),
        ),
        body: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                ),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),

                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
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