// lib/pages/home.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: const Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
