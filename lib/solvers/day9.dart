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

  String part1(String input) {
    var diskMap = generateDiskmap(input);
    var cList = diskMap.compactFiles();
    return checkSumPart1(cList).toString();
  }

  String part2(String input) {
    var diskMap = generateDiskmap(input);
    var cList = diskMap.compactFilesLessFragmentation();
    return checkSumPart2(cList).toString();
  }

  String printMap2(List<Block> map) {
    var s = "";
    for (var e in map) {
      s += e.filledSpaceListToString();
    }

    return s;
  }

  int checkSumPart1(List<Block> compactedFiles) {
    int checksum = 0;
    var cnt = 0;
    for (var b in compactedFiles) {
      List<int> l = List.filled(b.lengthOfFile + b.freeSpace, -1);
      var l2 = b.filledSpaceQueue.toList();
      for (var i = 0; i < l.length; i++) {
        if (b.filledSpaceQueue.isEmpty) {
          break;
        }
        l[i] = b.filledSpaceQueue.removeFirst();
      }
      for (var fb in l) {
        if (fb != -1) {
          checksum += cnt * fb;
        }

        cnt++;
      }
    }
    return checksum;
  }

  int checkSumPart2(List<Block> compactedFiles) {
    int checksum = 0;
    var cnt = 0;
    for (var b in compactedFiles) {
      for (var fb in b.filledSpaceList) {
        if (fb != -1) {
          checksum += cnt * fb;
        }

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

    while (inputQueue.isNotEmpty) {
      int lengthOfFreeSpace = 0;
      var d1 = inputQueue.removeFirst();
      if (inputQueue.isNotEmpty) {
        var d2 = inputQueue.removeFirst();
        lengthOfFreeSpace = int.parse(d2);
      }

      int id = cnt;
      int lengthOfFile = int.parse(d1);
      diskMap.map
          .add(Block(id, lengthOfFreeSpace, lengthOfFreeSpace, lengthOfFile));
      cnt++;
    }
    return diskMap;
  }
}
class DiskMap {
  final Queue<Block> map = Queue();
  List<Block> compactFiles() {
    Queue<Block> compactedFiles = Queue();
    while (map.isNotEmpty) {
      var currentBlock = map.last;
      var firstBlock = map.first;

      while (firstBlock.hasFreeSpace() &&
          currentBlock.filledSpaceQueue.isNotEmpty) {
        if (firstBlock == currentBlock) {
          compactedFiles.add(firstBlock);
          map.removeFirst();
          break;
        }
        var f = currentBlock.filledSpaceQueue.removeFirst();
        firstBlock.filledSpaceQueue.add(f);
      }
      if (currentBlock.filledSpaceQueue.isEmpty) {
        map.removeLast();
        continue;
      }
      if (firstBlock.hasFreeSpace() == false) {
        map.removeFirst();
        compactedFiles.add(firstBlock);
        continue;
      }
    }
    return compactedFiles.toList();
  }
  List<Block> compactFilesLessFragmentation() {
    List<Block> orderedList = List.from(map);
    orderedList.sort((a, b) => a.id.compareTo(b.id));
    var l = [];
    for (var i = orderedList.length - 1; i >= 0; i--) {
      var e1 = orderedList[i];
      for (var k = 0; k <= i; k++) {
        var e2 = orderedList[k];
        if (e2.hasFreeSpaceForBlock(e1)) {
          e2.addBlock(e1);
          break;
        }
      }
    }
    return orderedList.toList();
  }
}

class Block {
  int id;
  int freeSpace;
  int currentFreespaceCount;
  int lengthOfFile;
  late Queue<int> filledSpaceQueue;
  late List<int> filledSpaceList;
  List<int> file = [];

  Block(
      this.id, this.freeSpace, this.currentFreespaceCount, this.lengthOfFile) {
    filledSpaceQueue = Queue<int>();
    file = List.filled(lengthOfFile, id);
    filledSpaceList = List.filled(lengthOfFile + freeSpace, -1);
    for (var i = 0; i < lengthOfFile; i++) {
      filledSpaceList[i] = id;
    }
    filledSpaceQueue.addAll(file);
  }
  bool hasFreeSpace() {
    return filledSpaceQueue.length < lengthOfFile + freeSpace;
  }

  bool hasFreeSpaceForBlock(Block b) {
    var max = (lengthOfFile + freeSpace);
    var currentSize = filledSpaceList.where((x) => x != -1).length;
    return (max - currentSize).abs() >= b.file.length;
  }

  List<int> emptyFilledSpace() {
    List<int> blocks = [];
    for (var i = 0; i < file.length; i++) {
      blocks.add(filledSpaceQueue.removeFirst());
    }
    return blocks;
  }

  String filledSpaceQueueToString() {
    var s = "";
    List<int> l = List.filled(lengthOfFile + freeSpace, -1);
    var l2 = filledSpaceQueue.toList();
    for (var i = 0; i < l.length; i++) {
      if (i >= filledSpaceQueue.length) {
        break;
      }
      l[i] = filledSpaceQueue.elementAt(i);
    }
    return toBlockString(l);
  }

  String toBlockString(List<int> fl) {
    var s = "";
    for (var fb in fl) {
      if (fb == -1) {
        s += ".";
      } else {
        s += "$fb";
      }
    }
    return s;
  }

  String filledSpaceListToString() {
    return toBlockString(filledSpaceList);
  }

  void addBlock(Block e1) {
    for (var i = 0; i < e1.filledSpaceList.length; i++) {
      var e = e1.filledSpaceList[i];
      if (e != e1.id) {
        continue;
      }
      if (e == -1) {
        continue;
      }
      e1.filledSpaceList[i] = -1;
      var idx = filledSpaceList.indexWhere((i) => i == -1);
      filledSpaceList[idx] = e;
    }
  }
}
