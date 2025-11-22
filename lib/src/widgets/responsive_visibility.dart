import 'package:flutter/widgets.dart';
import '../core/breakpoint.dart';
import '../extensions/context_extensions.dart';

/// Widget that shows/hides based on breakpoint
class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final List<Breakpoint> visible;
  final Widget? replacement;

  const ResponsiveVisibility({
    super.key,
    required this.child,
    required this.visible,
    this.replacement,
  });

  /// Creates a widget visible only on mobile
  factory ResponsiveVisibility.mobile({
    Key? key,
    required Widget child,
    Widget? replacement,
  }) {
    return ResponsiveVisibility(
      key: key,
      visible: [Breakpoint.mobile],
      replacement: replacement,
      child: child,
    );
  }

  /// Creates a widget visible only on tablet
  factory ResponsiveVisibility.tablet({
    Key? key,
    required Widget child,
    Widget? replacement,
  }) {
    return ResponsiveVisibility(
      key: key,
      visible: [Breakpoint.tablet],
      replacement: replacement,
      child: child,
    );
  }

  /// Creates a widget visible only on desktop and larger
  factory ResponsiveVisibility.desktopAndUp({
    Key? key,
    required Widget child,
    Widget? replacement,
  }) {
    return ResponsiveVisibility(
      key: key,
      visible: [Breakpoint.laptop, Breakpoint.desktop, Breakpoint.web],
      replacement: replacement,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentBreakpoint = context.breakpoint;
    final isVisible = visible.contains(currentBreakpoint);

    if (isVisible) {
      return child;
    }

    return replacement ?? const SizedBox.shrink();
  }
}
