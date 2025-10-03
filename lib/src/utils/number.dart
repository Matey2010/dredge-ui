import 'dart:math';

int generateRandomInt({required int max, int min = 0}) {
  return min + Random().nextInt(max - min);
}
