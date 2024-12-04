// lib/solvers/day3.dart
import 'package:flutter/services.dart' show rootBundle;

class Day4Solver {
  //N, NE, E, SE, S, SW, W, NW
  final List<(int, int)> directions = [
    (-1, 0), // N
    (-1, 1), // NE
    (0, 1), // E
    (1, 1), // SE
    (1, 0), // S
    (1, -1), // SW
    (0, -1), // W
    (-1, -1), // NW
  ];
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day4.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 4 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  String part1(String input) {
    var map = input.split('\n').map((e)=>e.trim()).toList();
    int count = 0;
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        for (var dir in directions) {
          if (matchWord('XMAS', map, row, col, dir.$1, dir.$2)) {
            count++;
          }
        }
      }
    }
    return count.toString();
  }

 String part2(String input) {
    var map = input.split('\n').map((e)=>e.trim()).toList();
    var rows = map.length;
    var cols = map[0].length;
    int count = 0;

    for (int i = 1; i < rows - 1; i++) {
      for (int j = 1; j < cols - 1; j++) {
        var diag1 = [map[i - 1][j - 1], map[i][j], map[i + 1][j + 1]];
        var diag2 = [map[i - 1][j + 1], map[i][j], map[i + 1][j - 1]];

        if (isMASSam(diag1) && isMASSam(diag2)) {
          count++;
        }
      }
    }

    return count.toString();
  }
  bool isMASSam(List<String> letters) {
    return (letters[0] == 'M' && letters[1] == 'A' && letters[2] == 'S') || (letters[0] == 'S' && letters[1] == 'A' && letters[2] == 'M');
  }

  bool matchWord(String word, List<String> grid, int row, int col, int dx, int dy) {
    for (int i = 0; i < word.length; i++) {
      int newRow = row + i * dx;
      int newCol = col + i * dy;
      if (newRow < 0 ||
          newRow >= grid.length ||
          newCol < 0 ||
          newCol >= grid[0].length) {
        return false;
      }
      if (grid[newRow][newCol] != word[i]) {
        return false;
      }
    }
    return true;
  }

}
