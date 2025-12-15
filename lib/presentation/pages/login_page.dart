import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false, // 👈 REMOVE A SETA
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Login bem-sucedido → vai para biometria
            Navigator.pushReplacementNamed(context, '/biometric');
          },
          child: const Text('Entrar'),
        ),
      ),
    );
  }
}
