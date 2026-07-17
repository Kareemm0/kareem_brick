import 'package:flutter/material.dart';

/// Route-level wrapper that provides pull-to-refresh on **any** screen,
/// regardless of whether the screen contains a scrollable widget.
///
/// [RefreshIndicator] requires a scrollable descendant to detect overscroll.
/// To satisfy this universally, [child] is wrapped in a
/// [SingleChildScrollView] with [AlwaysScrollableScrollPhysics] — making every
/// screen draggable regardless of its own content.
///
/// [LayoutBuilder] is used to capture the viewport height *before*
/// [SingleChildScrollView] introduces unbounded vertical constraints.
/// [SizedBox] then re-constrains [child] to exactly that height, so widgets
/// inside the screen that rely on bounded constraints (e.g. [Column] with
/// [Expanded] children) continue to work correctly.
///
/// [notificationPredicate] is set to `(_) => true` so that overscroll
/// notifications from *any* descendant scrollable (not just the outermost one)
/// are caught — this covers screens whose body already has a [ListView] or
/// [SingleChildScrollView].
///
/// On pull, [_refreshKey] is incremented. [KeyedSubtree] propagates the new
/// key into the child subtree, causing Flutter to tear it down and remount it
/// from scratch — triggering every `initState` and reloading all data without
/// any navigation.
class RefreshableWrapper extends StatefulWidget {
  /// The screen widget to wrap with pull-to-refresh.
  final Widget child;

  const RefreshableWrapper({super.key, required this.child});

  @override
  State<RefreshableWrapper> createState() => _RefreshableWrapperState();
}

class _RefreshableWrapperState extends State<RefreshableWrapper> {
  int _refreshKey = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () async => setState(() => _refreshKey++),
        notificationPredicate: (_) => true,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: KeyedSubtree(
              key: ValueKey(_refreshKey),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
