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

  String part1(String input) {
    var targetNumbersSplit =
        input.split("\n").map((e) => e.split(": ")).toList();
    var operators = ["+", "*"];
    var total = 0;
    for (var targetNumber in targetNumbersSplit) {
      var target = int.parse(targetNumber[0].trim());
      var numbers = targetNumber[1].split(" ").map(int.parse).toList();
      
      if (canFormTarget(target, numbers,operators)) {
        total += target;
      }
    }

    return total.toString();
  }

  String part2(String input) {
     var targetNumbersSplit =
        input.split("\n").map((e) => e.split(": ")).toList();
    var operators = ["+", "*", "||"];
    var total = 0;
    for (var targetNumber in targetNumbersSplit) {
      var target = int.parse(targetNumber[0].trim());
      var numbers = targetNumber[1].split(" ").map(int.parse).toList();
      
      if (canFormTarget(target, numbers,operators)) {
        total += target;
      }
    }

    return total.toString();
  }

  bool canFormTarget(int target, List<int> numbers,List<String> ops) {
    // If there's only one number, just compare directly.
    if (numbers.length == 1) {
      return numbers[0] == target;
    }
    int slots = numbers.length - 1;
    int totalCombinations = 1;
    for (int i = 0; i < slots; i++) {
      totalCombinations *= ops.length;
    }

    // Iterate through all combinations:
    // We'll do a base-3 count to generate operator combinations (0->'+', 1->'*', 2->'||').
    for (int combo = 0; combo < totalCombinations; combo++) {
      List<String> operators = [];
      int temp = combo;
      for (int i = 0; i < slots; i++) {
        operators.add(ops[temp % ops.length]);
        temp ~/= ops.length;
      }

      if (evaluateExpression(numbers, operators) == target) {
        return true;
      }
    }

    return false;
  }

  int evaluateExpression(List<int> numbers, List<String> operators) {
    int currentValue = numbers[0];

    for (int i = 0; i < operators.length; i++) {
      String op = operators[i];
      int nextNum = numbers[i + 1];

      if (op == '||') {
        //Concatenate digits: e.g., 12 || 345 = 12345.
        //new_value = current_value * (10^(number_of_digits_in_nextNum)) + nextNum
        currentValue = concatenate(currentValue, nextNum);
      } else if (op == '+') {
        currentValue = currentValue + nextNum;
      } else {
        // op == '*'
        currentValue = currentValue * nextNum;
      }
    }

    return currentValue;
  }

  int concatenate(int a, int b) {
    // Concatenate number b to the right of number a.
    // Example: a=12, b=345 => 12*1000 + 345 = 12345
    int digits = countDigits(b);
    return a * pow10(digits) + b;
  }

  int countDigits(int x) {
    if (x == 0) return 1;
    int count = 0;
    int val = x.abs(); // handle negative if ever needed
    while (val > 0) {
      val ~/= 10;
      count++;
    }
    return count;
  }

  int pow10(int n) {
    // Compute 10^n
    int result = 1;
    for (int i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }
}
