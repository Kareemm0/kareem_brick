import 'package:flutter/material.dart';

import '../../core/core.dart' show CustomFilledButtonTheme;

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final void Function(bool)? onHover;
  final VoidCallback? onLongPress;
  final WidgetStatesController? statesController;
  final bool isLoading;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.statesController,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final customTheme = switch (Theme.of(context).buttonTheme) {
      final CustomFilledButtonTheme theme => theme,
      _ => null,
    };

    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: isLoading ? null : onLongPress,
      statesController: statesController,
      child: Builder(builder: (context) {
        const loading = CircularProgressIndicator();
        return isLoading
            ? customTheme?.loadingBuilder?.call(context, loading) ?? loading
            : child;
      }),
    );
  }
}
