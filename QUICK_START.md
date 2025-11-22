# Respix Quick Start Guide

## Installation

```yaml
dependencies:
  respix: ^0.0.1
```

## Setup (One Time)

Wrap your app with `ResponsiveConfig`:

### Option 1: Single Design Size (Simple)
Use one design size for all breakpoints:

```dart
import 'package:respix/respix.dart';

void main() {
  runApp(
    ResponsiveConfig(
      designSize: const Size(375, 812), // Used for all breakpoints
      child: MyApp(),
    ),
  );
}
```

### Option 2: Different Design Size Per Breakpoint (Advanced)
Set specific design sizes for each layout:

```dart
void main() {
  runApp(
    ResponsiveConfig(
      mobileDesignSize: const Size(375, 812),    // iPhone 11 Pro
      tabletDesignSize: const Size(768, 1024),   // iPad
      desktopDesignSize: const Size(1920, 1080), // Desktop
      // laptop and web will cascade from desktop
      child: MyApp(),
    ),
  );
}
```

## Common Use Cases

### 1. Responsive Values (Most Common)

```dart
// Padding
padding: EdgeInsets.all(
  context.responsive(mobile: 8, tablet: 16, desktop: 24)
)

// Font size
fontSize: context.responsive(mobile: 14, desktop: 18)

// Any type works!
color: context.responsive(
  mobile: Colors.blue,
  desktop: Colors.purple,
)
```

### 2. Different Layouts

```dart
ResponsiveBuilder(
  mobile: (context) => Column(children: [...]),
  desktop: (context) => Row(children: [...]),
)
```

### 3. Show/Hide Elements

```dart
// Show only on desktop
ResponsiveVisibility.desktopAndUp(
  child: Sidebar(),
)

// Hide on mobile
ResponsiveVisibility(
  visible: [Breakpoint.tablet, Breakpoint.desktop],
  child: AdvancedFeature(),
)
```

### 4. Responsive Text

```dart
ResponsiveText(
  'Hello World',
  mobileFontSize: 16,
  desktopFontSize: 24,
)
```

### 5. Responsive Padding

```dart
ResponsivePadding.all(
  mobile: 16,
  desktop: 32,
  child: YourWidget(),
)
```

### 6. Responsive Grid

```dart
ResponsiveGrid(
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 3,
  children: [...],
)
```

## Breakpoint Checks

```dart
if (context.isMobile) {
  // Mobile logic
}

if (context.isDesktop) {
  // Desktop logic
}

// Or get the enum
final breakpoint = context.breakpoint;
```

## Smart Fallback

You only need to specify values that change:

```dart
// Tablet, laptop, and web will all use 16
context.responsive(
  mobile: 8,
  desktop: 16,
)
```

Fallback order:
- Web → Desktop → Laptop → Tablet → Mobile
- Desktop → Laptop → Tablet → Mobile
- Laptop → Tablet → Mobile
- Tablet → Mobile
- Mobile (required)

## Custom Configuration

### Custom Breakpoints
```dart
ResponsiveConfig(
  breakpointConfig: BreakpointConfig(
    mobile: 480,
    tablet: 768,
    laptop: 1024,
    desktop: 1440,
  ),
  child: MyApp(),
)
```

### Per-Breakpoint Design Sizes
```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),    // Mobile design reference
  tabletDesignSize: const Size(768, 1024),   // Tablet design reference
  laptopDesignSize: const Size(1366, 768),   // Laptop design reference
  desktopDesignSize: const Size(1920, 1080), // Desktop design reference
  webDesignSize: const Size(2560, 1440),     // Large screen reference
  child: MyApp(),
)
```

### Combined Configuration
```dart
ResponsiveConfig(
  // Custom breakpoints
  breakpointConfig: BreakpointConfig(
    mobile: 480,
    tablet: 768,
    laptop: 1024,
    desktop: 1440,
  ),
  // Per-breakpoint design sizes
  mobileDesignSize: const Size(360, 640),
  tabletDesignSize: const Size(768, 1024),
  desktopDesignSize: const Size(1920, 1080),
  child: MyApp(),
)
```

## Tips

1. **Start with mobile** - Always provide a mobile value as the base
2. **Only specify changes** - Use fallback logic to reduce code
3. **Use context extensions** - `context.responsive()` is your friend
4. **Check breakpoints** - Use `context.isMobile` for conditional logic
5. **Wrap once** - Only wrap your app once with `ResponsiveConfig`

## Complete Example

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePadding.all(
        mobile: 16,
        desktop: 32,
        child: Column(
          children: [
            ResponsiveText(
              'Title',
              mobileFontSize: 24,
              desktopFontSize: 32,
            ),
            
            SizedBox(height: context.responsive(mobile: 16, desktop: 24)),
            
            ResponsiveBuilder(
              mobile: (context) => Column(children: [
                Card1(),
                Card2(),
              ]),
              desktop: (context) => Row(children: [
                Expanded(child: Card1()),
                SizedBox(width: 24),
                Expanded(child: Card2()),
              ]),
            ),
            
            ResponsiveVisibility.desktopAndUp(
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
```

That's it! You're ready to build responsive Flutter apps with Respix.
