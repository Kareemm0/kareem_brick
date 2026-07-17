import '../core.dart';

abstract interface class SharedPrefs {
  FutureEitherFailureOr<Set<String>> getKeys({Set<String>? allowList});

  FutureEitherFailureOr<Map<String, Object?>> getAll({Set<String>? allowList});

  FutureEitherFailureOr<bool?> getBool(String key);

  FutureEitherFailureOr<int?> getInt(String key);

  FutureEitherFailureOr<double?> getDouble(String key);

  FutureEitherFailureOr<String?> getString(String key);

  FutureEitherFailureOr<List<String>?> getStringList(String key);

  FutureEitherFailureOr<bool> containsKey(String key);

  FutureEitherFailureOr<Nothing> setBool(String key, bool value);

  FutureEitherFailureOr<Nothing> setInt(String key, int value);

  FutureEitherFailureOr<Nothing> setDouble(String key, double value);

  FutureEitherFailureOr<Nothing> setString(String key, String value);

  FutureEitherFailureOr<Nothing> setStringList(String key, List<String> value);

  FutureEitherFailureOr<Nothing> remove(String key);

  FutureEitherFailureOr<Nothing> clear({Set<String>? allowList});
}
