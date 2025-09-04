extension MapExtensions<K, V> on Map<K, V> {
  // Remove all entries where value is null
  Map<K, V> nonNulls() =>
      Map.fromEntries(entries.where((entry) => entry.value != null));

  // Merge two maps (with optional override)
  Map<K, V> merge(Map<K, V> other, {bool overwrite = true}) => {
        ...this,
        ...other
      }..removeWhere((k, v) => !overwrite && other.containsKey(k));
}
