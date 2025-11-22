# Respix

An extremely simple, intuitive API for building fully responsive Flutter applications across mobile, tablet, laptop, desktop, and web layouts.

## Features

✨ **Zero Boilerplate** - Make anything responsive in one line  
🎯 **Type-Safe** - Works with any type using generics  
📱 **5 Breakpoints** - Mobile, Tablet, Laptop, Desktop, Web  
🔄 **Smart Fallback** - Automatic cascade logic (tablet → mobile if not specified)  
📐 **Flexible Design Sizes** - Single design size OR per-breakpoint design sizes  
🎨 **Pre-built Widgets** - Ready-to-use responsive components  
⚡ **Zero Dependencies** - Pure Flutter, no external packages  
🌳 **Tree-Shakeable** - Only import what you use

## Breakpoint System

| Breakpoint | Width Range | Default Threshold |
|------------|-------------|-------------------|
| Mobile     | < 600px     | < 600 |
| Tablet     | 600-900px   | 600-900 |
| Laptop     | 900-1200px  | 900-1200 |
| Desktop    | 1200-1600px | 1200-1600 |
| Web        | > 1600px    | > 1600 |

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  respix: ^0.0.1
```

## Quick Start

### 1. Wrap your app with ResponsiveConfig

**Option A: Single Design Size (Simple)**
```dart
import 'package:respix/respix.dart';

void main() {
  runApp(
    ResponsiveConfig(
      designSize: const Size(375, 812), // One size for all breakpoints
      child: MyApp(),
    ),
  );
}
```

**Option B: Per-Breakpoint Design Sizes (Advanced)**
```dart
void main() {
  runApp(
    ResponsiveConfig(
      mobileDesignSize: const Size(375, 812),    // Mobile design
      tabletDesignSize: const Size(768, 1024),   // Tablet design
      desktopDesignSize: const Size(1920, 1080), // Desktop design
      child: MyApp(),
    ),
  );
}
```

See [DESIGN_SIZE_GUIDE.md](DESIGN_SIZE_GUIDE.md) for detailed comparison.

### 2. Use responsive values anywhere

```dart
// Simple value selection
padding: EdgeInsets.all(
  context.responsive(
    mobile: 8,
    tablet: 16,
    desktop: 24,
  ),
)

// Only specify what changes (auto-fallback)
fontSize: context.responsive(
  mobile: 14,
  desktop: 18, // tablet/laptop will use 14
)
```

## Usage Examples

### Responsive Text

```dart
ResponsiveText(
  'Hello World',
  mobileFontSize: 14,
  tabletFontSize: 18,
  desktopFontSize: 22,
  style: TextStyle(fontWeight: FontWeight.bold),
)
```

### Layout Switching

```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

### Responsive Padding

```dart
ResponsivePadding.all(
  mobile: 16,
  tablet: 24,
  desktop: 32,
  child: YourWidget(),
)

// Or symmetric
ResponsivePadding.symmetric(
  mobileHorizontal: 16,
  desktopHorizontal: 48,
  child: YourWidget(),
)
```

### Conditional Visibility

```dart
ResponsiveVisibility(
  visible: [Breakpoint.tablet, Breakpoint.desktop],
  child: SideNavigation(),
)

// Or use shortcuts
ResponsiveVisibility.mobile(
  child: MobileMenu(),
)

ResponsiveVisibility.desktopAndUp(
  child: DesktopSidebar(),
)
```

### Responsive Grid

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

### Context Extensions

```dart
// Check current breakpoint
if (context.isMobile) {
  // Mobile-specific logic
}

// Get breakpoint enum
final breakpoint = context.breakpoint;

// Boolean helpers
context.isMobile
context.isTablet
context.isLaptop
context.isDesktop
context.isWeb

// Screen dimensions
context.screenWidth
context.screenHeight
```

### Numeric Extensions

```dart
// Scaled pixels (based on design size)
Text('Hello', style: TextStyle(fontSize: 16.sp(context)))

// Width/Height percentages
Container(
  width: 50.widthPercent(context),  // 50% of screen width
  height: 30.heightPercent(context), // 30% of screen height
)
```

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

Set different design sizes for each breakpoint:

```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),    // Mobile design
  tabletDesignSize: const Size(768, 1024),   // Tablet design
  laptopDesignSize: const Size(1366, 768),   // Laptop design
  desktopDesignSize: const Size(1920, 1080), // Desktop design
  webDesignSize: const Size(2560, 1440),     // Large screen
  child: MyApp(),
)
```

This allows `.sp()` scaling to be accurate for each device category.

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:respix/respix.dart';

void main() {
  runApp(
    ResponsiveConfig(
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Respix Demo'),
      ),
      body: ResponsivePadding.all(
        mobile: 16,
        tablet: 24,
        desktop: 32,
        child: Column(
          children: [
            // Responsive text
            ResponsiveText(
              'Welcome',
              mobileFontSize: 24,
              desktopFontSize: 32,
            ),
            
            SizedBox(height: context.responsive(mobile: 16, desktop: 24)),
            
            // Different layouts per breakpoint
            ResponsiveBuilder(
              mobile: (context) => Column(
                children: [
                  ProfileCard(),
                  ContentCard(),
                ],
              ),
              desktop: (context) => Row(
                children: [
                  Expanded(child: ProfileCard()),
                  SizedBox(width: 24),
                  Expanded(flex: 2, child: ContentCard()),
                ],
              ),
            ),
            
            // Show only on desktop
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

## API Reference

### Widgets

- `ResponsiveConfig` - Global configuration wrapper
- `ResponsiveBuilder` - Build different layouts per breakpoint
- `ResponsiveText` - Auto-scaling text
- `ResponsiveImage` - Adaptive images
- `ResponsivePadding` - Adaptive padding
- `ResponsiveSpacing` - Adaptive spacing
- `ResponsiveGrid` - Grid with responsive columns
- `ResponsiveVisibility` - Show/hide per breakpoint

### Extensions

- `context.responsive<T>()` - Get responsive value
- `context.breakpoint` - Current breakpoint enum
- `context.isMobile/isTablet/etc` - Boolean helpers
- `context.screenWidth/screenHeight` - Screen dimensions
- `num.sp(context)` - Scaled pixels
- `num.widthPercent(context)` - Width percentage
- `num.heightPercent(context)` - Height percentage

### Core Classes

- `Breakpoint` - Enum for breakpoints
- `BreakpointConfig` - Custom breakpoint thresholds
- `ResponsiveValue<T>` - Value holder with fallback logic

## Design Philosophy

Respix prioritizes **developer experience** through:

1. **Minimal API Surface** - Learn once, use everywhere
2. **Smart Defaults** - Sensible fallback behavior
3. **Type Safety** - Catch errors at compile time
4. **Zero Magic** - Explicit and predictable behavior
5. **Composability** - Mix and match features freely

## License

MIT License - see LICENSE file for details
