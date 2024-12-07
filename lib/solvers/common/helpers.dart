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
}