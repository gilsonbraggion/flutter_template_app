import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final bool canAuthenticate =
          await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) return false;

      return await _auth.authenticate(
        localizedReason: 'Confirme sua identidade',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
