import 'package:flutter/widgets.dart';
import '../core/breakpoint.dart';
import '../extensions/context_extensions.dart';

/// Type definition for builder functions
typedef ResponsiveWidgetBuilder = Widget Function(BuildContext context);

/// Widget that rebuilds based on breakpoint changes
class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder? mobile;
  final ResponsiveWidgetBuilder? tablet;
  final ResponsiveWidgetBuilder? laptop;
  final ResponsiveWidgetBuilder? desktop;
  final ResponsiveWidgetBuilder? web;

  const ResponsiveBuilder({
    super.key,
    this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.web,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = context.breakpoint;
    
    ResponsiveWidgetBuilder? builder;
    switch (breakpoint) {
      case Breakpoint.web:
        builder = web ?? desktop ?? laptop ?? tablet ?? mobile;
        break;
      case Breakpoint.desktop:
        builder = desktop ?? laptop ?? tablet ?? mobile;
        break;
      case Breakpoint.laptop:
        builder = laptop ?? tablet ?? mobile;
        break;
      case Breakpoint.tablet:
        builder = tablet ?? mobile;
        break;
      case Breakpoint.mobile:
        builder = mobile;
        break;
    }

    if (builder == null) {
      throw FlutterError(
        'ResponsiveBuilder must have at least a mobile builder defined.',
      );
    }

    return builder(context);
  }
}
