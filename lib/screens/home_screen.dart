// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../solvers/solver_factory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _output = '';
  int _selectedDay = 1; // Default to Day 1

  bool _isLoading = false;

  void _solve() async {
    setState(() {
      _isLoading = true;
      _output = 'Solving Day $_selectedDay... Please wait.';
    });

    final solver = SolverFactory.getSolver(_selectedDay);

    if (solver != null) {
      try {
        String result = await solver.solve();
         setState(() {
          _isLoading = false;
          _output = result;
        });
      } catch (e) {
        setState(() {
          _output = 'An error occurred: $e';
        });
      }
    } else {
      setState(() {
        _output = 'Solver for Day $_selectedDay not implemented yet.';
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Advent of Code Solver'),
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
                onPressed: _isLoading ? null : _solve,
                child: _isLoading ? const CircularProgressIndicator() : const Text('Solve'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _output,
                    style: const TextStyle(fontFamily: '"Source Code Pro", monospace'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
