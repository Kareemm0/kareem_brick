extension NullableMapper<T, R> on T? {
  R? map(R Function(T) mapper) => switch (this) {
        final value? => mapper(value),
        null => null,
      };
}
