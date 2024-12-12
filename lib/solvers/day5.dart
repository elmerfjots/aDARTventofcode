// lib/solvers/day2.dart
import 'package:flutter/services.dart' show rootBundle;

class Day5Solver {
  Future<String> solve() async {
    // Load the input file from assets
    final input = await rootBundle.loadString('inputs/day5.txt');

    final part1Result = part1(input);
    final part2Result = part2(input);

    return 'Day 5 Solution:\nPart 1: $part1Result\nPart 2: $part2Result';
  }

  String part1(String input) {
    var orders = <int, List<int>>{};
    List<List<int>> updates = [];
    fillOrdersAndUpdatesFromInput(input, orders, updates);
    List<List<int>> goodUpdates =
        updates.where((e) => isUpdateGood(e, orders)).toList();
    return goodUpdates
        .map((e) => e[(e.length / 2).floor()]) //Middle
        .reduce((a, b) => a + b) //Sum
        .toString();
  }

  String part2(String input) {
    var orderingRules = <int, List<int>>{};
    List<List<int>> updates = [];
    fillOrdersAndUpdatesFromInput(input, orderingRules, updates);
    List<int> middlePageNumbers = [];

    for (var update in updates) {
      if (isOrderedCorrectly(update,orderingRules)) {
        continue; // Skip correctly ordered updates
      } else {
        var orderedUpdate = orderCorrectly(update,orderingRules);
        middlePageNumbers.add(orderedUpdate[orderedUpdate.length ~/ 2]);
      }
    }

    // Sum of middle page numbers
    int result = middlePageNumbers.reduce((a, b) => a + b);
    return "$result";
  }
  bool isOrderedCorrectly(List<int> update, Map<int, List<int>> orderingRules) {
    Map<int, int> indexMap = {
      for (int i = 0; i < update.length; i++) update[i]: i
    };
    for (var x in orderingRules.keys) {
      if (!indexMap.containsKey(x)) continue;
      for (var y in orderingRules[x]!) {
        if (!indexMap.containsKey(y)) continue;
        if (indexMap[x]! > indexMap[y]!) return false;
      }
    }
    return true;
  }
  List<int> orderCorrectly(
      List<int> update, Map<int, List<int>> orderingRules) {
    Set<int> visited = {};
    List<int> ordered = [];

    void dfs(int page) {
      if (visited.contains(page)) return;
      visited.add(page);
      if (orderingRules.containsKey(page)) {
        for (var dependent in orderingRules[page]!) {
          if (update.contains(dependent)) {
            dfs(dependent);
          }
        }
      }
      ordered.add(page);
    }

    for (var page in update) {
      dfs(page);
    }

    return ordered.reversed.toList();
  }

  fillOrdersAndUpdatesFromInput(
      String input, Map<int, List<int>> orders, List<List<int>> updates) {
    var orderUpdates = input.split("\n").map((e) => e.trim());
    var ordersFound = false;
    for (var o in orderUpdates) {
      if (ordersFound) {
        var updateInts = o.split(",").map(int.parse).toList();
        updates.add(updateInts);
      } else if (o == "") {
        ordersFound = true;
        continue;
      } else {
        var orderSplit = o.split("|");
        if (orders[int.parse(orderSplit[0])] == null) {
          orders[int.parse(orderSplit[0])] = [int.parse(orderSplit[1])];
        } else {
          orders[int.parse(orderSplit[0])]?.add(int.parse(orderSplit[1]));
        }
      }
    }
  }

  isUpdateGood(List<int> update, Map<int, List<int>> orders) {
    for (var i = 0; i < update.length; i++) {
      var e = update[i];
      var o = orders[e];
      if (o == null && i != update.length - 1) {
        return false;
      }
      for (var k = i + 1; k < update.length; k++) {
        var eInner = update[k];
        var found = o?.where((e) => e == eInner).toList();
        if (found!.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }
}
