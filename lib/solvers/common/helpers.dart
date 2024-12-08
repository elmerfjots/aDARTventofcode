class Helpers {

  static List<(int, int)> diagonalDirections = [
    (-1, 0), // N
    (-1, 1), // NE
    (0, 1), // E
    (1, 1), // SE
    (1, 0), // S
    (1, -1), // SW
    (0, -1), // W
    (-1, -1), // NW
  ];
  static List<(int, int)> nonDiagonalDirections = [
    (-1, 0), // N
    (0, 1), // E
    (1, 0), // S
    (0, -1), // W
  ];
  static String replaceCharAt(String oldString, int index, String newChar) { 
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }
  static bool isOutOfBounds((int, int) currentGuardPosition, List<String> map) {
    return (currentGuardPosition.$1 < 0 ||
            currentGuardPosition.$1 > map.length - 1) ||
        (currentGuardPosition.$2 < 0 ||
            currentGuardPosition.$2 > map[0].length - 1);
  }
  static int gcd(int a, int b) {
    while (b != 0) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}
}