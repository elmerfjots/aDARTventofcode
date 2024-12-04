// lib/solvers/day3.dart

import 'package:flutter/services.dart' show rootBundle;

class Day3Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day3.txt');
    final part1Result = part1(input);
    final part2Result = part2(input);
    return 'Day 3 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  String part1(String input) {
    List<(int, String)> instructions = getAllInstructions(input);
    int total = 0;

    instructions.map((e)=>extractNumbersFromMul(e.$2)).forEach((e) {
      if(e != null){
         total += e.$1 * e.$2;
      }
    });

    return total.toString();
  }

  String part2(String input) {
    var instructions = getAllInstructions(input);
    bool doing = true;
    int total = 0;

    for (var instr in instructions) {
      String text = instr.$2;

      if (text == 'do()') {
        doing = true;
      } else if (text == "don't()") {
        doing = false;
      } else if (text.startsWith('mul') && doing) {
        // Extract the numbers from the mul instruction
        var nums = extractNumbersFromMul(text);
        if (nums != null) {
          total += nums.$1 * nums.$2;
        }
      }
    }

    return total.toString();
  }

  (int, int)? extractNumbersFromMul(String mulText) {
    RegExp exp = RegExp(r'mul\((-?\d+),(-?\d+)\)');
    var match = exp.firstMatch(mulText);
    if (match != null) {
      int num1 = int.parse(match.group(1)!);
      int num2 = int.parse(match.group(2)!);
      return (num1, num2);
    }
    return null;
  }

  List<(int, String)> getAllInstructions(String input) {
    RegExp exp = RegExp(r"mul\(-?\d+,-?\d+\)|do\(\)|don't\(\)");
    List<(int, String)> instructions = [];
    for (var match in exp.allMatches(input)) {
      instructions.add((match.start,match[0].toString()));
    }
    instructions.sort((a, b) => a.$1.compareTo(b.$1));
    return instructions;
  }
}
