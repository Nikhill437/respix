import 'package:flutter/widgets.dart';
import '../extensions/context_extensions.dart';

/// Padding widget that adapts based on breakpoint
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobile;
  final EdgeInsets? tablet;
  final EdgeInsets? laptop;
  final EdgeInsets? desktop;
  final EdgeInsets? web;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.web,
  });

  /// Creates responsive padding with uniform values
  factory ResponsivePadding.all({
    Key? key,
    required Widget child,
    double? mobile,
    double? tablet,
    double? laptop,
    double? desktop,
    double? web,
  }) {
    return ResponsivePadding(
      key: key,
      mobile: mobile != null ? EdgeInsets.all(mobile) : null,
      tablet: tablet != null ? EdgeInsets.all(tablet) : null,
      laptop: laptop != null ? EdgeInsets.all(laptop) : null,
      desktop: desktop != null ? EdgeInsets.all(desktop) : null,
      web: web != null ? EdgeInsets.all(web) : null,
      child: child,
    );
  }

  /// Creates responsive padding with symmetric values
  factory ResponsivePadding.symmetric({
    Key? key,
    required Widget child,
    double? mobileHorizontal,
    double? tabletHorizontal,
    double? laptopHorizontal,
    double? desktopHorizontal,
    double? webHorizontal,
    double? mobileVertical,
    double? tabletVertical,
    double? laptopVertical,
    double? desktopVertical,
    double? webVertical,
  }) {
    return ResponsivePadding(
      key: key,
      mobile: EdgeInsets.symmetric(
        horizontal: mobileHorizontal ?? 0,
        vertical: mobileVertical ?? 0,
      ),
      tablet: tabletHorizontal != null || tabletVertical != null
          ? EdgeInsets.symmetric(
              horizontal: tabletHorizontal ?? 0,
              vertical: tabletVertical ?? 0,
            )
          : null,
      laptop: laptopHorizontal != null || laptopVertical != null
          ? EdgeInsets.symmetric(
              horizontal: laptopHorizontal ?? 0,
              vertical: laptopVertical ?? 0,
            )
          : null,
      desktop: desktopHorizontal != null || desktopVertical != null
          ? EdgeInsets.symmetric(
              horizontal: desktopHorizontal ?? 0,
              vertical: desktopVertical ?? 0,
            )
          : null,
      web: webHorizontal != null || webVertical != null
          ? EdgeInsets.symmetric(
              horizontal: webHorizontal ?? 0,
              vertical: webVertical ?? 0,
            )
          : null,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.responsive<EdgeInsets>(
      mobile: mobile ?? EdgeInsets.zero,
      tablet: tablet,
      laptop: laptop,
      desktop: desktop,
      web: web,
    );

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

/// Spacing widget that adapts based on breakpoint
class ResponsiveSpacing extends StatelessWidget {
  final double? mobile;
  final double? tablet;
  final double? laptop;
  final double? desktop;
  final double? web;
  final bool horizontal;

  const ResponsiveSpacing({
    super.key,
    this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.web,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsive<double>(
      mobile: mobile ?? 0,
      tablet: tablet,
      laptop: laptop,
      desktop: desktop,
      web: web,
    );

    return SizedBox(
      width: horizontal ? spacing : null,
      height: horizontal ? null : spacing,
    );
  }
}
