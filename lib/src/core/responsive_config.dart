import 'package:flutter/widgets.dart';
import 'breakpoint_config.dart';
import 'breakpoint.dart';

/// Global configuration for responsive behavior
class ResponsiveConfig extends InheritedWidget {
  final BreakpointConfig breakpointConfig;
  final Size designSize;
  final Size? mobileDesignSize;
  final Size? tabletDesignSize;
  final Size? laptopDesignSize;
  final Size? desktopDesignSize;
  final Size? webDesignSize;
  final bool useOrientation;

  const ResponsiveConfig({
    super.key,
    required super.child,
    this.breakpointConfig = BreakpointConfig.defaultConfig,
    this.designSize = const Size(375, 812), // Default fallback
    this.mobileDesignSize,
    this.tabletDesignSize,
    this.laptopDesignSize,
    this.desktopDesignSize,
    this.webDesignSize,
    this.useOrientation = false,
  });

  /// Gets the design size for a specific breakpoint
  Size getDesignSizeForBreakpoint(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return mobileDesignSize ?? designSize;
      case Breakpoint.tablet:
        return tabletDesignSize ?? mobileDesignSize ?? designSize;
      case Breakpoint.laptop:
        return laptopDesignSize ?? tabletDesignSize ?? mobileDesignSize ?? designSize;
      case Breakpoint.desktop:
        return desktopDesignSize ?? laptopDesignSize ?? tabletDesignSize ?? mobileDesignSize ?? designSize;
      case Breakpoint.web:
        return webDesignSize ?? desktopDesignSize ?? laptopDesignSize ?? tabletDesignSize ?? mobileDesignSize ?? designSize;
    }
  }

  static ResponsiveConfig? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveConfig>();
  }

  static ResponsiveConfig of(BuildContext context) {
    final config = maybeOf(context);
    if (config != null) return config;
    return ResponsiveConfig(child: Container());
  }

  @override
  bool updateShouldNotify(ResponsiveConfig oldWidget) {
    return breakpointConfig != oldWidget.breakpointConfig ||
        designSize != oldWidget.designSize ||
        mobileDesignSize != oldWidget.mobileDesignSize ||
        tabletDesignSize != oldWidget.tabletDesignSize ||
        laptopDesignSize != oldWidget.laptopDesignSize ||
        desktopDesignSize != oldWidget.desktopDesignSize ||
        webDesignSize != oldWidget.webDesignSize ||
        useOrientation != oldWidget.useOrientation;
  }
}
