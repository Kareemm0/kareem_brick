import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigHelper {
  RemoteConfigHelper._();

  static FirebaseRemoteConfig? _remoteConfig;

  static Future<void> init({
    FirebaseOptions? options,
    Map<String, dynamic>? defaults,
    Duration fetchTimeout = const Duration(seconds: 10),
    Duration minimumFetchInterval = const Duration(hours: 1),
    bool enableDeveloperMode = kDebugMode,
  }) async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(options: options);
      }

      _remoteConfig = FirebaseRemoteConfig.instance;

      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: fetchTimeout,
          minimumFetchInterval: enableDeveloperMode
              ? Duration.zero
              : minimumFetchInterval,
        ),
      );

      if (defaults != null && defaults.isNotEmpty) {
        await _remoteConfig!.setDefaults(defaults);
      }

      final activated = await _remoteConfig!.fetchAndActivate();

      if (kDebugMode) {
        debugPrint('Remote Config initialized. Activated: $activated');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config initialization failed: $e');
      }
      rethrow;
    }
  }

  static void _ensureInitialized() {
    if (_remoteConfig == null) {
      throw Exception('RemoteConfigHelper not initialized. Call init() first.');
    }
  }

  static String getString(String key, {String defaultValue = ''}) {
    try {
      _ensureInitialized();
      return _remoteConfig!.getString(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config getString($key) failed: $e');
      }
      return defaultValue;
    }
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    try {
      _ensureInitialized();
      return _remoteConfig!.getBool(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config getBool($key) failed: $e');
      }
      return defaultValue;
    }
  }

  static int getInt(String key, {int defaultValue = 0}) {
    try {
      _ensureInitialized();
      return _remoteConfig!.getInt(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config getInt($key) failed: $e');
      }
      return defaultValue;
    }
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    try {
      _ensureInitialized();
      return _remoteConfig!.getDouble(key);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config getDouble($key) failed: $e');
      }
      return defaultValue;
    }
  }

  static Future<bool> fetchAndActivate() async {
    try {
      _ensureInitialized();
      final activated = await _remoteConfig!.fetchAndActivate();

      if (kDebugMode) {
        debugPrint('Remote Config fetched. Activated: $activated');
      }

      return activated;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Remote Config fetch failed: $e');
      }
      return false;
    }
  }

  static Set<String> getKeys() {
    try {
      _ensureInitialized();
      return _remoteConfig!.getAll().keys.toSet();
    } catch (e) {
      return {};
    }
  }

  static Map<String, dynamic> getAllValues() {
    try {
      _ensureInitialized();
      final all = _remoteConfig!.getAll();
      return all.map((key, value) => MapEntry(key, value.asString()));
    } catch (e) {
      return {};
    }
  }

  static Stream<RemoteConfigUpdate> get onConfigUpdated {
    _ensureInitialized();
    return _remoteConfig!.onConfigUpdated;
  }

  static void listenForUpdates(
    void Function(Set<String> updatedKeys) onUpdate,
  ) {
    _ensureInitialized();

    _remoteConfig!.onConfigUpdated.listen((update) async {
      if (kDebugMode) {
        debugPrint('Remote Config updated: ${update.updatedKeys}');
      }

      await _remoteConfig!.activate();

      onUpdate(update.updatedKeys);
    });
  }
}
