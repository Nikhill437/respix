# Respix API Reference

## Table of Contents
- [Configuration](#configuration)
- [Core Classes](#core-classes)
- [Context Extensions](#context-extensions)
- [Numeric Extensions](#numeric-extensions)
- [Widgets](#widgets)

---

## Configuration

### ResponsiveConfig

Global configuration widget that should wrap your MaterialApp.

```dart
ResponsiveConfig({
  Key? key,
  required Widget child,
  BreakpointConfig breakpointConfig = BreakpointConfig.defaultConfig,
  Size designSize = const Size(375, 812),
  Size? mobileDesignSize,
  Size? tabletDesignSize,
  Size? laptopDesignSize,
  Size? desktopDesignSize,
  Size? webDesignSize,
  bool useOrientation = false,
})
```

**Parameters:**
- `child` - Your app widget (typically MaterialApp)
- `breakpointConfig` - Custom breakpoint thresholds
- `designSize` - Default design size (fallback for all breakpoints)
- `mobileDesignSize` - Design size specifically for mobile
- `tabletDesignSize` - Design size specifically for tablet
- `laptopDesignSize` - Design size specifically for laptop
- `desktopDesignSize` - Design size specifically for desktop
- `webDesignSize` - Design size specifically for web
- `useOrientation` - Enable orientation handling (future feature)

**Example 1: Single Design Size**
```dart
ResponsiveConfig(
  designSize: Size(375, 812),
  child: MaterialApp(...),
)
```

**Example 2: Per-Breakpoint Design Sizes**
```dart
ResponsiveConfig(
  mobileDesignSize: Size(375, 812),    // iPhone
  tabletDesignSize: Size(768, 1024),   // iPad
  desktopDesignSize: Size(1920, 1080), // Desktop
  child: MaterialApp(...),
)
```

**Example 3: Combined Configuration**
```dart
ResponsiveConfig(
  breakpointConfig: BreakpointConfig(
    mobile: 480,
    tablet: 768,
    laptop: 1024,
    desktop: 1440,
  ),
  mobileDesignSize: Size(360, 640),
  tabletDesignSize: Size(768, 1024),
  desktopDesignSize: Size(1920, 1080),
  child: MaterialApp(...),
)
```

---

## Core Classes

### Breakpoint (Enum)

Represents the five screen size categories.

```dart
enum Breakpoint {
  mobile,
  tablet,
  laptop,
  desktop,
  web,
}
```

**Properties:**
- `isMobile` → bool
- `isTablet` → bool
- `isLaptop` → bool
- `isDesktop` → bool
- `isWeb` → bool

### BreakpointConfig

Configuration for breakpoint thresholds.

```dart
BreakpointConfig({
  double mobile = 600,
  double tablet = 900,
  double laptop = 1200,
  double desktop = 1600,
  double web = double.infinity,
})
```

**Static:**
- `BreakpointConfig.defaultConfig` - Default configuration

**Methods:**
- `getBreakpoint(double width)` → Breakpoint

**Example:**
```dart
const config = BreakpointConfig(
  mobile: 480,
  tablet: 768,
  laptop: 1024,
  desktop: 1440,
);
```

### ResponsiveValue<T>

Generic value holder with cascade fallback logic.

```dart
ResponsiveValue<T>({
  T? mobile,
  T? tablet,
  T? laptop,
  T? desktop,
  T? web,
})
```

**Methods:**
- `getValue(Breakpoint breakpoint)` → T

**Example:**
```dart
const value = ResponsiveValue<int>(
  mobile: 10,
  desktop: 30,
);
```

---

## Context Extensions

### ResponsiveContext

Extension on BuildContext providing responsive functionality.

#### responsive<T>()

Returns responsive value based on current breakpoint.

```dart
T responsive<T>({
  T? mobile,
  T? tablet,
  T? laptop,
  T? desktop,
  T? web,
})
```

**Example:**
```dart
final padding = context.responsive<double>(
  mobile: 8,
  tablet: 16,
  desktop: 24,
);
```

#### breakpoint

Gets the current breakpoint enum.

```dart
Breakpoint get breakpoint
```

**Example:**
```dart
final current = context.breakpoint;
if (current == Breakpoint.mobile) { ... }
```

#### Boolean Helpers

Quick breakpoint checks.

```dart
bool get isMobile
bool get isTablet
bool get isLaptop
bool get isDesktop
bool get isWeb
```

**Example:**
```dart
if (context.isMobile) {
  // Mobile-specific code
}
```

#### Screen Dimensions

```dart
double get screenWidth
double get screenHeight
Size get designSize
```

**Example:**
```dart
final width = context.screenWidth;
final height = context.screenHeight;
```

---

## Numeric Extensions

### ResponsiveNum

Extension on num for responsive sizing.

#### sp()

Scaled pixels based on design size.

```dart
double sp(BuildContext context)
```

**Example:**
```dart
fontSize: 16.sp(context)
```

#### w

Width percentage (0-100).

```dart
double get w
```

**Example:**
```dart
width: 50.w  // 50% of screen width
```

#### h

Height percentage (0-100).

```dart
double get h
```

**Example:**
```dart
height: 30.h  // 30% of screen height
```

### ResponsiveNumWithContext

Context-aware numeric extensions.

```dart
double widthPercent(BuildContext context)
double heightPercent(BuildContext context)
```

**Example:**
```dart
width: 50.widthPercent(context)
```

---

## Widgets

### ResponsiveBuilder

Widget that rebuilds based on breakpoint changes.

```dart
ResponsiveBuilder({
  Key? key,
  ResponsiveWidgetBuilder? mobile,
  ResponsiveWidgetBuilder? tablet,
  ResponsiveWidgetBuilder? laptop,
  ResponsiveWidgetBuilder? desktop,
  ResponsiveWidgetBuilder? web,
})
```

**Example:**
```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

### ResponsiveText

Text widget with auto-scaling font size.

```dart
ResponsiveText(
  String data, {
  Key? key,
  TextStyle? style,
  double? mobileFontSize,
  double? tabletFontSize,
  double? laptopFontSize,
  double? desktopFontSize,
  double? webFontSize,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  bool softWrap = true,
})
```

**Example:**
```dart
ResponsiveText(
  'Hello World',
  mobileFontSize: 16,
  tabletFontSize: 20,
  desktopFontSize: 24,
  style: TextStyle(fontWeight: FontWeight.bold),
)
```

### ResponsiveImage

Image widget with adaptive sizing.

```dart
ResponsiveImage({
  Key? key,
  required ImageProvider image,
  double? mobileWidth,
  double? tabletWidth,
  double? laptopWidth,
  double? desktopWidth,
  double? webWidth,
  double? mobileHeight,
  double? tabletHeight,
  double? laptopHeight,
  double? desktopHeight,
  double? webHeight,
  BoxFit? fit,
  AlignmentGeometry alignment = Alignment.center,
})
```

**Example:**
```dart
ResponsiveImage(
  image: AssetImage('logo.png'),
  mobileWidth: 100,
  desktopWidth: 200,
  fit: BoxFit.contain,
)
```

### ResponsivePadding

Padding widget with adaptive values.

```dart
ResponsivePadding({
  Key? key,
  required Widget child,
  EdgeInsets? mobile,
  EdgeInsets? tablet,
  EdgeInsets? laptop,
  EdgeInsets? desktop,
  EdgeInsets? web,
})
```

**Factory Constructors:**

#### ResponsivePadding.all()
```dart
ResponsivePadding.all({
  Key? key,
  required Widget child,
  double? mobile,
  double? tablet,
  double? laptop,
  double? desktop,
  double? web,
})
```

#### ResponsivePadding.symmetric()
```dart
ResponsivePadding.symmetric({
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
})
```

**Example:**
```dart
ResponsivePadding.all(
  mobile: 16,
  tablet: 24,
  desktop: 32,
  child: MyWidget(),
)
```

### ResponsiveSpacing

Spacing widget (SizedBox) with adaptive size.

```dart
ResponsiveSpacing({
  Key? key,
  double? mobile,
  double? tablet,
  double? laptop,
  double? desktop,
  double? web,
  bool horizontal = false,
})
```

**Example:**
```dart
ResponsiveSpacing(
  mobile: 16,
  desktop: 24,
  horizontal: true,
)
```

### ResponsiveGrid

Grid widget with responsive column count.

```dart
ResponsiveGrid({
  Key? key,
  required List<Widget> children,
  int? mobileColumns,
  int? tabletColumns,
  int? laptopColumns,
  int? desktopColumns,
  int? webColumns,
  double mainAxisSpacing = 8.0,
  double crossAxisSpacing = 8.0,
  double childAspectRatio = 1.0,
})
```

**Example:**
```dart
ResponsiveGrid(
  mobileColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
  mainAxisSpacing: 16,
  crossAxisSpacing: 16,
  children: [
    Card1(),
    Card2(),
    Card3(),
  ],
)
```

### ResponsiveVisibility

Widget that shows/hides based on breakpoint.

```dart
ResponsiveVisibility({
  Key? key,
  required Widget child,
  required List<Breakpoint> visible,
  Widget? replacement,
})
```

**Factory Constructors:**

#### ResponsiveVisibility.mobile()
```dart
ResponsiveVisibility.mobile({
  Key? key,
  required Widget child,
  Widget? replacement,
})
```

#### ResponsiveVisibility.tablet()
```dart
ResponsiveVisibility.tablet({
  Key? key,
  required Widget child,
  Widget? replacement,
})
```

#### ResponsiveVisibility.desktopAndUp()
```dart
ResponsiveVisibility.desktopAndUp({
  Key? key,
  required Widget child,
  Widget? replacement,
})
```

**Example:**
```dart
ResponsiveVisibility(
  visible: [Breakpoint.tablet, Breakpoint.desktop],
  child: Sidebar(),
  replacement: MobileMenu(),
)

// Or use shortcuts
ResponsiveVisibility.desktopAndUp(
  child: AdvancedFeature(),
)
```

---

## Type Definitions

### ResponsiveWidgetBuilder

```dart
typedef ResponsiveWidgetBuilder = Widget Function(BuildContext context);
```

Used by ResponsiveBuilder for layout functions.

---

## Cascade Fallback Logic

When a breakpoint value is not specified, it falls back to the next smaller breakpoint:

```
Web → Desktop → Laptop → Tablet → Mobile
Desktop → Laptop → Tablet → Mobile
Laptop → Tablet → Mobile
Tablet → Mobile
Mobile (required)
```

**Example:**
```dart
context.responsive(
  mobile: 8,
  desktop: 16,
)
// tablet and laptop will use 8
// web will use 16
```

---

## Import

```dart
import 'package:respix/respix.dart';
```

This single import gives you access to all Respix functionality.
