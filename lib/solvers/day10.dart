// lib/solvers/day2.dart
import 'package:aoc/solvers/common/helpers.dart';
import 'package:flutter/services.dart' show rootBundle;

class Day10Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day10.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 10 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  String part1(String input) {
    var sMap = input.split("\n").map((e) => e.trim()).toList();
    List<List<int>> map =
        sMap.map((e) => e.split('').map(int.parse).toList()).toList();
    int numRows = map.length;
    int numCols = map[0].length;
    int totalScore = 0;
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        if (map[r][c] == 0) {
          totalScore += findTrailheadScore(r, c, map);
        }
      }
    }
    return "$totalScore";
  }

  String part2(String input) {
    var sMap = input.split("\n").map((e) => e.trim()).toList();
    List<List<int>> map =
        sMap.map((e) => e.split('').map(int.parse).toList()).toList();
    int numRows = map.length;
    int numCols = map[0].length;
    int totalRating = 0;

    // Find all trailheads and calculate their ratings
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        if (map[r][c] == 0) {
          totalRating += findTrailheadRating(r, c, map);
        }
      }
    }
    return totalRating.toString();
  }

  //DFS
  int findTrailheadScore(int startRow, int startCol, List<List<int>> map) {
    Set<String> visited = {};
    List<List<int>> stack = [
      [startRow, startCol, 0]
    ];
    int score = 0;

    while (stack.isNotEmpty) {
      List<int> current = stack.removeLast();
      int r = current[0];
      int c = current[1];
      int height = current[2];

      String position = "$r,$c";
      if (visited.contains(position)) continue;
      visited.add(position);

      // If the height reaches 9, increment the score
      if (map[r][c] == 9) {
        score++;
        continue;
      }

      // Explore neighbors with the next expected height
      for (var dir in Helpers.nonDiagonalDirections) {
        int nr = r + dir.$1;
        int nc = c + dir.$2;
        if (Helpers.isOutOfBoundsIntMap((nr, nc), map) == false &&
            map[nr][nc] == height + 1) {
          stack.add([nr, nc, height + 1]);
        }
      }
    }

    return score;
  }

  int findTrailheadRating(int startRow, int startCol, List<List<int>> map) {
    Set<List<(int, int)>> uniquePaths = {};
    findAllRoutes(startRow, startCol, map[startRow][startCol],
        {"$startRow,$startCol"}, uniquePaths, map);
    return uniquePaths.length;
  }

  //DFS with pathstates
  void findAllRoutes(int r, int c, int currentHeight, Set<String> visited,
      Set<List<(int, int)>> paths, List<List<int>> map) {
    if (map[r][c] == 9) {
      paths.add(visited
          .map((v) => v.split(','))
          .map((l) => (int.parse(l[0]), int.parse(l[1])))
          .toList());
      return;
    }
    for (var dir in Helpers.nonDiagonalDirections) {
      int nr = r + dir.$1;
      int nc = c + dir.$2;

      if (Helpers.isOutOfBoundsIntMap((nr, nc), map) == false &&
          map[nr][nc] == currentHeight + 1) {
        String position = "$nr,$nc";
        if (!visited.contains(position)) {
          visited.add(position);
          findAllRoutes(nr, nc, map[nr][nc], visited, paths, map);
          visited.remove(position);
        }
      }
    }
  }
}
