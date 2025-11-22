import 'package:flutter/widgets.dart';
import 'context_extensions.dart';

/// Extension for scaled pixels based on design size
extension ResponsiveNum on num {
  /// Scaled pixels - scales based on screen width relative to design width
  double sp(BuildContext context) {
    final designWidth = context.designSize.width;
    final screenWidth = context.screenWidth;
    return this * (screenWidth / designWidth);
  }

  /// Width percentage - returns percentage of screen width
  double get w {
    return this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / 
           WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio / 100;
  }

  /// Height percentage - returns percentage of screen height
  double get h {
    return this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height / 
           WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio / 100;
  }
}

/// Extension for responsive numeric values with context
extension ResponsiveNumWithContext on num {
  /// Width percentage using context
  double widthPercent(BuildContext context) {
    return this * context.screenWidth / 100;
  }

  /// Height percentage using context
  double heightPercent(BuildContext context) {
    return this * context.screenHeight / 100;
  }
}
