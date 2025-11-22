import '../core/breakpoint.dart';

/// Holds responsive values for different breakpoints with cascade fallback
class ResponsiveValue<T> {
  final T? mobile;
  final T? tablet;
  final T? laptop;
  final T? desktop;
  final T? web;

  const ResponsiveValue({
    this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.web,
  });

  /// Gets the value for the given breakpoint with cascade fallback
  T getValue(Breakpoint breakpoint) {
    switch (breakpoint) {
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
}
