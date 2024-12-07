// lib/solvers/day2.dart
import 'package:flutter/services.dart' show rootBundle;

class Day7Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day7.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 7 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  String part1(String input){
    return "";
  }
  String part2(String input){
    return "";
  }
}