import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const AdventOfCodeApp());
}

class AdventOfCodeApp extends StatelessWidget {
  const AdventOfCodeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent of Code Solver',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x000f0f23),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00cccccc)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}




