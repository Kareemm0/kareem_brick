import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_hooks/flutter_hooks.dart' show Hook, HookState, use;

import 'throttler.dart' show Throttler;

/// A Flutter hook that provides a [Throttler] instance with automatic lifecycle management.
///
/// The throttler is initialized when the hook is first used and automatically disposed
/// when the widget is unmounted. New actions are dropped if a previous action is still
/// within the throttle period.
///
/// Example usage:
/// ```dart
/// final throttler = useThrottler(delay: const Duration(milliseconds: 300));
///
/// // In your widget:
/// ElevatedButton(
///   onPressed: () => throttler.call(() => performAction()),
///   child: Text('Action'),
/// )
/// ```
Throttler useThrottler({Duration delay = const Duration(milliseconds: 500)}) {
  return use(_ThrottlerHook(delay: delay));
}

class _ThrottlerHook extends Hook<Throttler> {
  final Duration delay;

  const _ThrottlerHook({required this.delay});

  @override
  HookState<Throttler, Hook<Throttler>> createState() => _ThrottlerState();
}

class _ThrottlerState extends HookState<Throttler, _ThrottlerHook> {
  late Throttler throttler;

  @override
  void initHook() {
    super.initHook();
    throttler = Throttler(delay: hook.delay);
  }

  @override
  Throttler build(BuildContext context) => throttler;

  @override
  void dispose() {
    throttler.dispose();
    super.dispose();
  }
}
