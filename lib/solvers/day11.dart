// lib/solvers/day2.dart
import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;

class Day11Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day11.txt');

    final part1Result = await part1(input);
    final part2Result = await part2(input);

    return 'Day 11 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  Future<String> part1(String input) async{
    var initialArrangement = input.split(" ").map((e)=>e.trim()).map(int.parse).toList();
    var blinks = 25;
    var q1 = Queue<int>();
    q1.addAll(initialArrangement);
    for(var i = 0;i<blinks;i++){
      var bq = Queue<int>();
      while(q1.isNotEmpty){
        var e = q1.removeFirst();
        transform(e,bq);
      }
      q1.addAll(bq);
    }
    return q1.length.toString();
  }
  Future<String> part2(String input) async{
    return "";
  }
  
  void transform(int e, Queue<int> bq) {
    if(e==0){
      bq.add(1);
      return;
    }
    String numberString = e.abs().toString();
    //even
    if(numberString.length%2==0){
      String part1 = numberString.substring(0, numberString.length ~/ 2);
      String part2 = numberString.substring(numberString.length ~/ 2);
      bq.add(int.parse(part1));
      bq.add(int.parse(part2));
      return;
    }
    bq.add(e*2024);
  }
}