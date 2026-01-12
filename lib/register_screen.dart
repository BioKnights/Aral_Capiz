import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Username")),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("CREATE ACCOUNT"),
            ),

            GestureDetector(
  onTap: () {
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
  },
  child: const Text(
    "Create an account",
    style: TextStyle(
      color: Colors.white70,
      decoration: TextDecoration.underline,
    ),
  ),
),


            
          ],
        ),
      ),
    );
  }
}
