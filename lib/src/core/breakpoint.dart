/// Enum representing different screen breakpoints
enum Breakpoint {
  mobile,
  tablet,
  laptop,
  desktop,
  web;

  /// Returns true if this is mobile breakpoint
  bool get isMobile => this == Breakpoint.mobile;

  /// Returns true if this is tablet breakpoint
  bool get isTablet => this == Breakpoint.tablet;

  /// Returns true if this is laptop breakpoint
  bool get isLaptop => this == Breakpoint.laptop;

  /// Returns true if this is desktop breakpoint
  bool get isDesktop => this == Breakpoint.desktop;

  /// Returns true if this is web breakpoint
  bool get isWeb => this == Breakpoint.web;
}
