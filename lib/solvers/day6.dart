// lib/solvers/day2.dart
import 'dart:collection';
import 'package:flutter/services.dart' show rootBundle;
import 'common/helpers.dart';

class Day6Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day6.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 6 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  String part1(String input) {
    var map = input.split("\n").map((e) => e.trim()).toList();
    var guardPosition = getGuardPosition(map);
    var distinctPositions = moveGuard(guardPosition, map);
    return distinctPositions.toString();
  }

  String part2(String input) {
    var map = input.split("\n").map((e) => e.trim()).toList();
    var guardStart = getGuardPosition(map);

    final rows = map.length;
    final cols = map[0].length;

    int loopCount = 0;
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if ((r, c) != guardStart && map[r][c] == '.') {
          var newMap = List<String>.from(map);
          newMap[r] = Helpers.replaceCharAt(newMap[r], c, 'O');
          if (moveGuardCreatesLoop(guardStart, newMap)) {
            loopCount++;
          }
        }
      }
    }
    return loopCount.toString();
  }

  getGuardPosition(List<String> map) {
    var guards = map.map((e) => RegExp(r'[\^]').firstMatch(e)).toList();
    var idxRow = guards.indexWhere((e) => e != null);
    var idxCol = guards[idxRow]?.start;
    return (idxRow, idxCol);
  }

  int moveGuard((int row, int col) guardPosition, List<String> map) {
    bool isMoving = true;
    HashSet<(int, int)> visitedNode = HashSet<(int, int)>();
    var filledMap = List<String>.from(map);
    var currentGuardPosition = (guardPosition.$1, guardPosition.$2);
    var currentDirectionIdx = 0; //N

    while (isMoving) {
      if (isOutOfBounds(currentGuardPosition, map)) {
        // out of bounds
        isMoving = false;
        break;
      }
      visitedNode.add(currentGuardPosition);
      filledMap[currentGuardPosition.$1] = Helpers.replaceCharAt(
          filledMap[currentGuardPosition.$1], currentGuardPosition.$2, 'X');
      var dir = Helpers.nonDiagonalDirections[currentDirectionIdx];
      var dirClear =
          directionIsClear(dir, currentGuardPosition, map, filledMap);
      if (dirClear.$1) {
        currentGuardPosition = dirClear.$2;
      } else {
        currentDirectionIdx =
            (currentDirectionIdx == Helpers.nonDiagonalDirections.length - 1
                ? 0
                : currentDirectionIdx + 1);
      }
    }
    return visitedNode.length;
  }

  bool moveGuardCreatesLoop(
      (int row, int col) guardPosition, List<String> map) {
    bool isMoving = true;
    HashSet<(int, int)> visitedNode = HashSet<(int, int)>();
    var filledMap = List<String>.from(map);
    var currentGuardPosition = (guardPosition.$1, guardPosition.$2);
    var currentDirectionIdx = 0; //N
    var stateSet = HashSet<(int row, int col, int dx, int dy)>();
    while (isMoving) {
      if (isOutOfBounds(currentGuardPosition, map)) {
        // out of bounds
        isMoving = false;
        return false;
      }

      visitedNode.add(currentGuardPosition);
      filledMap[currentGuardPosition.$1] = Helpers.replaceCharAt(
          filledMap[currentGuardPosition.$1], currentGuardPosition.$2, 'X');
      var dir = Helpers.nonDiagonalDirections[currentDirectionIdx];

      var currentState =
          (currentGuardPosition.$1, currentGuardPosition.$2, dir.$1, dir.$2);
      if (stateSet.contains(currentState)) {
        return true;
      }
      stateSet.add(currentState);
      var dirClear =
          directionIsClear(dir, currentGuardPosition, map, filledMap);
      if (dirClear.$1) {
        currentGuardPosition = dirClear.$2;
      } else {
        currentDirectionIdx =
            (currentDirectionIdx == Helpers.nonDiagonalDirections.length - 1
                ? 0
                : currentDirectionIdx + 1);
      }
    }
    return false;
  }

  (bool, (int row, int col)) directionIsClear(
      (int, int) currentDirection,
      (int, int) currentGuardPosition,
      List<String> map,
      List<String> filledMap) {
    int newRow = currentGuardPosition.$1 + (1 * currentDirection.$1);
    int newCol = currentGuardPosition.$2 + (1 * currentDirection.$2);
    if ((newRow < 0 || newRow > map.length - 1) ||
        (newCol < 0 || newCol > map[0].length - 1)) {
      return (true, (newRow, newCol));
    }
    if (map[newRow][newCol] == "#" || map[newRow][newCol] == "O") {
      return (false, (newRow, newCol));
    }
    return (true, (newRow, newCol));
  }

  bool isOutOfBounds((int, int) currentGuardPosition, List<String> map) {
    return (currentGuardPosition.$1 < 0 ||
            currentGuardPosition.$1 > map.length - 1) ||
        (currentGuardPosition.$2 < 0 ||
            currentGuardPosition.$2 > map[0].length - 1);
  }
}
