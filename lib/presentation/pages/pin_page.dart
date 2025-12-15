import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final _controller = TextEditingController();
  final String correctPin = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digite seu PIN')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'PIN',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text == correctPin) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
