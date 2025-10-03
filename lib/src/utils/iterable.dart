extension IterableExtensions<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) mapper) {
    int index = 0;
    return map((element) => mapper(index++, element));
  }

  void forEachIndexed(void Function(int index, T item) action) {
    int index = 0;
    for (final item in this) {
      action(index++, item);
    }
  }

  T? firstWhereOrNull(bool Function(T element) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
