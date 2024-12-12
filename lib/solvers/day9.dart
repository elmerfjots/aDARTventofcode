// lib/solvers/day2.dart
import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;

class Day9Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day9.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 9 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }
  String part1(String input){
    var diskMap = generateDiskmap(input);
    var cList = diskMap.compactFiles();
    return diskMap.printMap() + checkSum(cList).toString();
  }
  String part2(String input){
    var diskMap = generateDiskmap(input);
    
    return "";
  }
  int checkSum(List<Block>compactedFiles){
    int checksum = 0;
    var cnt = 0;
    for(var b in compactedFiles){
      for(var fb in b.filledSpace){
        checksum += cnt * fb;
        cnt++;  
      }
    }
    return checksum;
  }
  
  DiskMap generateDiskmap(String input) {
    var diskMap = DiskMap();
    var inputQueue = Queue<String>();
    inputQueue.addAll(input.split(""));
    var cnt = 0;

    while(inputQueue.isNotEmpty){
      int lengthOfFreeSpace = 0;
      var d1 = inputQueue.removeFirst();
      if(inputQueue.isNotEmpty){
          var d2 = inputQueue.removeFirst();
          lengthOfFreeSpace = int.parse(d2);
      }
    
      int id = cnt;
      int lengthOfFile = int.parse(d1);
      diskMap.map.add(Block(id,lengthOfFreeSpace,lengthOfFreeSpace,lengthOfFile));
      cnt++;
    }
    return diskMap;
  }
}
class DiskMap{
  final Queue<Block> map = Queue();
  List<Block> compactFiles(){
    Queue<Block> compactedFiles = Queue();
    while(map.isNotEmpty){
      var currentBlock = map.last;
      var firstBlock = map.first;
      
      while(firstBlock.hasFreeSpace() && currentBlock.filledSpace.isNotEmpty){
        if(firstBlock == currentBlock){
          compactedFiles.add(firstBlock);
          map.removeFirst();
          break;
        }
        var f  = currentBlock.filledSpace.removeFirst();
        firstBlock.filledSpace.add(f);
      }
      if(currentBlock.filledSpace.isEmpty){
        map.removeLast();
        continue;
      }
      if(firstBlock.hasFreeSpace() == false){
        map.removeFirst();
        compactedFiles.add(firstBlock);
        continue;
      }
    }
    return compactedFiles.toList();
  }
  String printMap(){
    var s = "";
    for(var e in map){
      s += e.toMapString();
    }

    return s;
  }
  
}
class Block {
  int id;
  int freeSpace;
  int currentFreespaceCount;
  int lengthOfFile;
  late Queue<int> filledSpace;
  List<int> file = [];

  Block(this.id,this.freeSpace,this.currentFreespaceCount,this.lengthOfFile) {
    filledSpace = Queue<int>();
    file = List.filled(lengthOfFile, id);
    filledSpace.addAll(file);
  }
  bool hasFreeSpace(){
    return filledSpace.length < lengthOfFile+freeSpace;
  }
  String toMapString(){
    return (id.toString() * lengthOfFile) + "." * freeSpace;
  }
  int checkSum(){
    return filledSpace.map((x)=>x*id).reduce((a,b)=>a+b);
  }
}