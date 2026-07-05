import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() {
  runApp(const EntryScreen());
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
