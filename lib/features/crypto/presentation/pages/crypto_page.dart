import 'package:flutter/material.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto'),
      ),
      body: const Center(
        child: Text(
          'Crypto Page (Coming Soon)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}