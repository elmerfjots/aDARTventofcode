// lib/solvers/day1.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Day1Solver {
  Future<String> solve() async {
    // Load the input file
    final input = await rootBundle.loadString('lib/inputs/day1.txt');

    // Parse and process the input
    final numbers = LineSplitter.split(input).map(int.parse).toList();

    // Implement your solution logic here
    // Example: Sum of numbers
    final sum = numbers.reduce((a, b) => a + b);

    return 'Day 1 Solution:\nSum of numbers is $sum';
  }
}
