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
          mainAxisSize: MainAxisSize.min,
          children: [
            _field("Username"),
            _field("Email"),
            _field("Password", obscure: true),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("CREATE ACCOUNT"),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
