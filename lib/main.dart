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
          scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 35),
          fontFamily: '"Source Code Pro", monospace', // Set your desired font family
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Color.fromRGBO(0, 153, 0, 1), // Set the default text color
                fontSize: 18.0, // Set the default font size
                fontWeight: FontWeight.normal, // Set the default font weight
              ),
              bodySmall: TextStyle(
                color: Color.fromRGBO(0, 153, 0, 1), // Set the default text color
                fontSize: 14.0, // Set the default font size
                fontWeight: FontWeight.normal, // Set the default font weight
              ),
              bodyMedium: TextStyle(
                color: Color.fromRGBO(0, 153, 0, 1), // Set the default text color
                fontSize: 16.0, // Set the default font size
                fontWeight: FontWeight.normal, // Set the default font weight
              ),
              // You can customize other text styles as needed
              headlineMedium: TextStyle(
                color: Color.fromRGBO(0, 153, 0, 1), // Set the default text color
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              )
          ),
      ),
      home: const HomeScreen(),
    );
  }
}
