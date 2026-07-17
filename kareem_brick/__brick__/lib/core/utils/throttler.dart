import 'dart:async' show Timer;

/// A utility class that throttles function execution by dropping new actions
/// if a previous action is still pending. Useful for rate limiting to ensure
/// actions are spaced out by at least the specified delay.
class Throttler {
  /// The minimum duration between action executions.
  final Duration delay;

  /// The internal timer used to track the cooldown period.
  Timer? _timer;

  /// Whether an action is currently being throttled.
  bool _isThrottling = false;

  /// Creates a new Throttler with an optional delay.
  ///
  /// [delay] defaults to 500 milliseconds if not provided.
  Throttler({this.delay = const Duration(milliseconds: 500)});

  /// Attempts to execute the provided [action] immediately if not currently
  /// throttling, otherwise drops the action.
  ///
  /// After executing an action, subsequent calls within the [delay] period
  /// will be ignored.
  void call(void Function() action) {
    if (!_isThrottling) {
      _isThrottling = true;
      action();
      _timer = Timer(delay, () {
        _isThrottling = false;
      });
    }
    // If throttling, silently drop the new action
  }

  /// Cancels any pending throttle cooldown and cleans up resources.
  ///
  /// This should be called when the Throttler is no longer needed to prevent
  /// memory leaks.
  void dispose() {
    _timer?.cancel();
    _isThrottling = false;
  }
}
