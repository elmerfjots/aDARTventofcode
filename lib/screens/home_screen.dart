// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../solvers/day1.dart'; // Import your solver(s) here

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = '';
  int _selectedDay = 1; // Default to Day 1

  void _solve() async {
    String result;

    switch (_selectedDay) {
      case 1:
        result = await Day1Solver().solve();
        break;
      // Add cases for other days
      default:
        result = 'Solver for Day $_selectedDay not implemented yet.';
    }

    setState(() {
      _output = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advent of Code Solver'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Dropdown to select the day
            Row(
              children: [
                const Text('Select Day:'),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  value: _selectedDay,
                  items: List.generate(25, (index) => index + 1)
                      .map((day) => DropdownMenuItem(
                            value: day,
                            child: Text('Day $day'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDay = value!;
                      _output = ''; // Clear previous output
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _solve,
              child: const Text('Solve'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}