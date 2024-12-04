// lib/solvers/day1.dart
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class Day1Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day1.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 1 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  int part1(String input){
    var lists = createLists(input);
    var distances = [];
    for(var i = 0;i<lists.$1.length;i++){
      var distance = (lists.$1[i] - lists.$2[i]).abs(); 
      distances.add(distance);
    }

    return distances.reduce((a, b) => a + b);
  }
  int part2(String input){
    var lists = createLists(input);
    var similarityScores = [];
    for (var i in lists.$1) {
      var occurence = countOccurenceOfNumberInList(i,lists.$2);
      similarityScores.add(i*occurence);
    }

    return similarityScores.reduce((a, b) => a + b);
  }
  (int,int) createPairs(String s){
    var split = s.split("   ");
    return (int.parse(split[0]),int.parse(split[1]));
  }
  (List<int>,List<int>) createLists(String input){
     final numbers = input.split('\n')
    .map((e) => 
      createPairs(e)
    ).toList();

    List<int> list1 = [];
    List<int> list2 = [];

    for (var n in numbers) {
      list1.add(n.$1);
      list2.add(n.$2);
    }
    list1.sort();
    list2.sort();
    return (list1,list2);
  }
  countOccurenceOfNumberInList(int i, List<int> list2) {
    var occurence = 0;
    for (var e in list2) {
      occurence = (e==i) ? occurence + 1 : occurence + 0;
    }
    return occurence;
  }
}