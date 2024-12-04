// lib/solvers/solver_factory.dart

// Import additional solvers as you implement them

import 'allSolvers.dart';

class SolverFactory {
  static final Map<int, Function> _solvers = {
    1: () => Day1Solver(),
    2: () => Day2Solver(),
    3: () => Day3Solver(),
    4: () => Day4Solver()
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
