// lib/solvers/day2.dart
import 'package:flutter/services.dart' show rootBundle;

class Day2Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day2.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 2 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  String part1(String input){
    var inputList = input.split("\n").map((e) => e.split(" ").map(int.parse).toList()).toList();
    var reports = getGoodAndBadReports(inputList,false);
    return reports.$1.length.toString();
  }
  String part2(String input){
    var inputList = input.split("\n").map((e) => e.split(" ").map(int.parse).toList()).toList();
    
    var reports = getGoodAndBadReports(inputList,true);



    //var goodreports2 = getGoodAndBadReports(reports.$2, false);

    return (reports.$1.length).toString();
  }
  (List<List<int>>goodReports,List<List<int>>badReports) getGoodAndBadReports(List<List<int>> inputList,bool removeBadIdx){
    List<List<int>> goodReports = [];
    List<List<int>> badReports = [];
    for (var ints in inputList) {
      var goodLevel = isLevelSafe(ints);
      if (goodLevel.$1) {
        goodReports.add(ints);
      } 
      else {
        bool madeSafe = false;
        if (removeBadIdx) {
          for (int i = 0; i < ints.length; i++) {
            List<int> arr = List<int>.from(ints);
            arr.removeAt(i);
            var nGoodLevel = isLevelSafe(arr);
            if (nGoodLevel.$1) {
              goodReports.add(ints); // Add the original report
              madeSafe = true;
              break;
            }
          }
        }
        if (!madeSafe) {
          badReports.add(ints);
        }
      }
  }
  return (goodReports, badReports);
  }
  (bool,int idxi,int idxi1) isLevelSafe(List<int> level){
    bool decreasing = false;
    bool levelSafe = false;
    for(var i = 0;i<level.length-1;i++){
      var diff = (level[i+1] - level[i]);
      var currDecreasing = (diff<0);
      if(i>0 && decreasing != currDecreasing){
        return (false,i,i+1);
      }
      decreasing = currDecreasing;
      diff = diff.abs();
      if(diff >= 1 && diff <= 3){
        levelSafe = true;
      }
      else{
        return (false,i,i+1);
      }
    }
    return (levelSafe,-1,-1);
  }
}
