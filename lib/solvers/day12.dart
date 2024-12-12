// lib/solvers/day2.dart
import 'dart:collection';

import 'package:aoc/solvers/common/helpers.dart';
import 'package:flutter/services.dart' show rootBundle;

class Day12Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day12.txt');

    final part1Result = await part1(input);
    final part2Result = await part2(input);

    return 'Day 12 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  Future<String> part1(String input) async {
    var gardenMap = input.split("\n").map((e) => e.trim()).toList();
    List<List<bool>> visited = List.generate(
        gardenMap.length, (_) => List.filled(gardenMap[0].length, false));
    // Calculate total price
    int totalPrice = 0;

    for (int row = 0; row < gardenMap.length; row++) {
      for (int col = 0; col < gardenMap[0].length; col++) {
        if (!visited[row][col]) {
          String plantType = gardenMap[row][col];
          var regionData =
              calculateRegion(row, col, gardenMap, plantType, visited);
          int area = regionData["area"]!;
          int perimeter = regionData["perimeter"]!;
          totalPrice += area * perimeter;
        }
      }
    }
    return "$totalPrice";
  }

  Future<String> part2(String input) async {
    return "";
  }
  Map<String, int> calculateRegion(int startRow, int startCol,
      List<String> gardenMap, String plantType, List<List<bool>> visited) {
    Queue<List<int>> queue = Queue();
    queue.add([startRow, startCol]);
    int rows = gardenMap.length;
    int cols = gardenMap[0].length;
    visited[startRow][startCol] = true;

    int area = 0;
    int perimeter = 0;

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      int row = current[0];
      int col = current[1];
      area++;

      for (var dir in Helpers.nonDiagonalDirections) {
        int newRow = row + dir.$1;
        int newCol = col + dir.$2;

        if (newRow < 0 ||
            newRow >= rows ||
            newCol < 0 ||
            newCol >= cols ||
            gardenMap[newRow][newCol] != plantType) {
          perimeter++; // Edge of the region
        } else if (!visited[newRow][newCol]) {
          visited[newRow][newCol] = true;
          queue.add([newRow, newCol]);
        }
      }
    }
    return {"area": area, "perimeter": perimeter};
  }
}
