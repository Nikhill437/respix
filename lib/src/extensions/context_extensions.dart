import 'package:flutter/widgets.dart';
import '../core/breakpoint.dart';
import '../core/breakpoint_config.dart';
import '../core/responsive_config.dart';

/// Extension on BuildContext for easy responsive access
extension ResponsiveContext on BuildContext {
  /// Gets the current breakpoint
  Breakpoint get breakpoint {
    final config = ResponsiveConfig.maybeOf(this);
    final breakpointConfig = config?.breakpointConfig ?? BreakpointConfig.defaultConfig;
    final width = MediaQuery.of(this).size.width;
    return breakpointConfig.getBreakpoint(width);
  }

  /// Returns true if current breakpoint is mobile
  bool get isMobile => breakpoint == Breakpoint.mobile;

  /// Returns true if current breakpoint is tablet
  bool get isTablet => breakpoint == Breakpoint.tablet;

  /// Returns true if current breakpoint is laptop
  bool get isLaptop => breakpoint == Breakpoint.laptop;

  /// Returns true if current breakpoint is desktop
  bool get isDesktop => breakpoint == Breakpoint.desktop;

  /// Returns true if current breakpoint is web
  bool get isWeb => breakpoint == Breakpoint.web;

  /// Returns responsive value based on current breakpoint
  T responsive<T>({
    T? mobile,
    T? tablet,
    T? laptop,
    T? desktop,
    T? web,
  }) {
    final currentBreakpoint = breakpoint;
    switch (currentBreakpoint) {
      case Breakpoint.web:
        return web ?? desktop ?? laptop ?? tablet ?? mobile as T;
      case Breakpoint.desktop:
        return desktop ?? laptop ?? tablet ?? mobile as T;
      case Breakpoint.laptop:
        return laptop ?? tablet ?? mobile as T;
      case Breakpoint.tablet:
        return tablet ?? mobile as T;
      case Breakpoint.mobile:
        return mobile as T;
    }
  }

  /// Gets screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Gets screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Gets design size from config (for current breakpoint)
  Size get designSize {
    final config = ResponsiveConfig.maybeOf(this);
    if (config == null) return const Size(375, 812);
    return config.getDesignSizeForBreakpoint(breakpoint);
  }

  /// Gets design size for a specific breakpoint
  Size designSizeFor(Breakpoint breakpoint) {
    final config = ResponsiveConfig.maybeOf(this);
    if (config == null) return const Size(375, 812);
    return config.getDesignSizeForBreakpoint(breakpoint);
  }
}
