import 'package:flutter/material.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}