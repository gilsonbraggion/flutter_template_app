import 'package:flutter/material.dart';
import '/services/auth_service.dart';

class BiometricPage extends StatelessWidget {
  const BiometricPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final success = await authService.authenticate();

            if (success) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacementNamed(context, '/pin');
            }
          },
          child: const Text('Desbloquear com Biometria'),
        ),
      ),
    );
  }
}
