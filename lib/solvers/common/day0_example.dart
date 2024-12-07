// lib/solvers/day2.dart
import 'package:flutter/services.dart' show rootBundle;

class Day0Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day1.txt');

    final part1Result = await part1(input);
    final part2Result = await part2(input);

    return 'Day 1 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  Future<String> part1(String input) async{
    return "";
  }
  Future<String> part2(String input) async{
    return "";
  }
}