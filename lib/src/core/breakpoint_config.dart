import 'breakpoint.dart';

/// Configuration for breakpoint thresholds
class BreakpointConfig {
  final double mobile;
  final double tablet;
  final double laptop;
  final double desktop;
  final double web;

  const BreakpointConfig({
    this.mobile = 600,
    this.tablet = 900,
    this.laptop = 1200,
    this.desktop = 1600,
    this.web = double.infinity,
  });

  /// Default breakpoint configuration
  static const defaultConfig = BreakpointConfig();

  /// Determines the current breakpoint based on width
  Breakpoint getBreakpoint(double width) {
    if (width < mobile) return Breakpoint.mobile;
    if (width < tablet) return Breakpoint.tablet;
    if (width < laptop) return Breakpoint.laptop;
    if (width < desktop) return Breakpoint.desktop;
    return Breakpoint.web;
  }
}
