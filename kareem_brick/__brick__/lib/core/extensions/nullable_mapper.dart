extension NullableMapper<T> on T? {
  U? map<U>(U Function(T) mapper, {bool Function()? predicate}) {
    return switch (this) {
      T value => (predicate == null || predicate()) ? mapper(value) : null,
      _ => null,
    };
  }
}
