// lib/solvers/day2.dart
import 'dart:collection';

import 'package:aoc/solvers/common/helpers.dart';
import 'package:flutter/services.dart' show rootBundle;

class Day8Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day8.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 8 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  String part1(String input) {
    var map = input.split("\n").map((e) => e.trim()).toList();
    List<(int, int, String)> antennas = findAntennas(map);
    //Find alle mulige par
    List<((int, int, String), (int, int, String))> possiblePairs =
        generatePairs(antennas);
    //For hvert par, find deres antinode - diffrow , diffcol og -(diffrow , diffcol)
    var antinodeMap = List<String>.from(map);
    HashSet<(int,int)> antinodes = getAntiNodes(possiblePairs,antinodeMap);
    //Tæl antinodes
    return antinodes.length.toString();
  }

  String part2(String input) {
    //The same as part 1, but now it is based on direction.
    //The loop should continue until it is out of bounds in the direction of the pair difference.
     var map = input.split("\n").map((e) => e.trim()).toList();
    List<(int, int, String)> antennas = findAntennas(map);
    //Find alle mulige par
    List<((int, int, String), (int, int, String))> possiblePairs =
        generatePairs(antennas);
    //For hvert par, find deres antinode - diffrow , diffcol og -(diffrow , diffcol)
    var antinodeMap = List<String>.from(map);
    var antinodes = getAntiNodesDirection(possiblePairs,antinodeMap);
    //Tæl antinodes
    return antinodes.length.toString();
  }

  List<(int, int, String)> findAntennas(List<String> map) {
    List<(int, int, String)> antennas = [];

    for (var row = 0; row < map.length; row++) {
      for (var col = 0; col < map[0].length; col++) {
        var mapValue = map[row][col];
        if (mapValue != '.') {
          antennas.add((row, col, mapValue));
        }
      }
    }
    return antennas;
  }

  List<((int, int, String), (int, int, String))> generatePairs(
      List<(int, int, String)> antennas) {
    // Initialize the list to store the resulting pairs
    List<((int, int, String), (int, int, String))> pairs = [];

    // Iterate through each antenna in the list
    for (int i = 0; i < antennas.length; i++) {
      for (int j = 0; j < antennas.length; j++) {
        // Compare the string values
        if (antennas[i].$3 == antennas[j].$3) {
          // Add the matching pair to the result list
          pairs.add((antennas[i], antennas[j]));
        }
      }
    }
    return pairs;
  }
  
  HashSet<(int, int)> getAntiNodes(List<((int, int, String), (int, int, String))> possiblePairs,List<String>antinodeMap) {
    //Hvis ny position er out of bounds - Så er det en ugyldig antinode
    //Tilføj antinode til HashSet hvis den er gyldig
    HashSet<(int,int)> antinodePositions = HashSet<(int,int)>();
    var rows = antinodeMap.length;
    var cols = antinodeMap[0].length;
    try{
      for (var pair in possiblePairs) {
        var rowDiff = pair.$1.$1-pair.$2.$1;
        var colDiff = pair.$1.$2-pair.$2.$2;
        var antennaId = pair.$1.$3;
        var a1 = (pair.$1.$1+rowDiff,pair.$1.$2+colDiff);
        var a2 = (pair.$1.$1+(-rowDiff),pair.$1.$2+(-colDiff));

        if(Helpers.isOutOfBounds(a1,antinodeMap) == false){
          if(antinodeMap[a1.$1][a1.$2] != antennaId){
            antinodePositions.add(a1);
            antinodeMap[a1.$1] = Helpers.replaceCharAt(antinodeMap[a1.$1],a1.$2,"#");
          }
        }
        if(Helpers.isOutOfBounds(a2,antinodeMap) == false){
          if(antinodeMap[a2.$1][a2.$2] != antennaId){
            antinodePositions.add(a2);
            antinodeMap[a2.$1] = Helpers.replaceCharAt(antinodeMap[a2.$1],a2.$2,"#");
          }
        }
      }
      return antinodePositions;
    }
    catch(e){
      return antinodePositions; 
    }
  }
}
Set<(int, int)> getAntiNodesDirection(
    List<((int, int, String), (int, int, String))> possiblePairs,
    List<String> antinodeMap) {
  final antinodePositions = <(int, int)>{};

  for (var pair in possiblePairs) {
    final (r1, c1, antennaId1) = pair.$1;
    final (r2, c2, antennaId2) = pair.$2;

    // Determine direction vector
    int rowDiff = r2 - r1;
    int colDiff = c2 - c1;

    // Reduce direction vector to simplest form
    int g = Helpers.gcd(rowDiff.abs(), colDiff.abs());
    if (g == 0) {
      // If both differences are zero, antennas overlap (edge case)
      continue;
    }

    int dr = rowDiff ~/ g;
    int dc = colDiff ~/ g;
    // Traverse forward
    {
      int rr = r1 + dr;
      int cc = c1 + dc;
      while (!Helpers.isOutOfBounds((rr, cc), antinodeMap)) {
        final currentChar = antinodeMap[rr][cc];
        if (currentChar != antennaId1) {
          antinodePositions.add((rr, cc));
          antinodeMap[rr] = Helpers.replaceCharAt(antinodeMap[rr], cc, "#");
        }
        rr += dr;
        cc += dc;
      }
    }
    // Traverse backward
    {
      int rr = r1 - dr;
      int cc = c1 - dc;
      while (!Helpers.isOutOfBounds((rr, cc), antinodeMap)) {
        final currentChar = antinodeMap[rr][cc];
        if (currentChar != antennaId1) {
          antinodePositions.add((rr, cc));
          antinodeMap[rr] = Helpers.replaceCharAt(antinodeMap[rr], cc, "#");
        }
        rr -= dr;
        cc -= dc;
      }
    }
    antinodePositions.add((r1, c1));
    antinodeMap[r1] = Helpers.replaceCharAt(antinodeMap[r1], c1, "#");
  }

  return antinodePositions;
}
}
