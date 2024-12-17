// lib/solvers/solver_factory.dart

// Import additional solvers as you implement them

import 'allSolvers.dart';

class SolverFactory {
  static final Map<int, Function> _solvers = {
    1: () => Day1Solver(),
    2: () => Day2Solver(),
    3: () => Day3Solver(),
    4: () => Day4Solver(),
    5: () => Day5Solver(),
    6: () => Day6Solver(),
    7: () => Day7Solver(),
    8: () => Day8Solver(),
    9: () => Day9Solver(),
    10: () => Day10Solver(),
    11: () => Day11Solver(),
    12: () => Day12Solver(),
 
    15: () => Day15Solver()
    // Add entries for additional days
  };

  static dynamic getSolver(int day) {
    final solverConstructor = _solvers[day];
    if (solverConstructor != null) {
      return solverConstructor();
    } else {
      return null;
    }
  }
}
