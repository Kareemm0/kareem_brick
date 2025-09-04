extension IterableExtension<T> on Iterable<T> {
  /// Returns the first element that satisfies the [predicate] or null
  /// if no such element exists.
  T? firstWhereOrNull(bool Function(T element) predicate) {
    for (var element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }
}
