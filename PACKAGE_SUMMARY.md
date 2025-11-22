# Respix Package Summary

## What is Respix?

Respix is an extremely simple, intuitive Flutter package for building fully responsive applications. It provides a clean API that makes any widget or value responsive in just one line of code.

## Package Structure

```
respix/
├── lib/
│   ├── respix.dart                          # Main export file
│   └── src/
│       ├── core/                            # Foundation layer
│       │   ├── breakpoint.dart              # Breakpoint enum
│       │   ├── breakpoint_config.dart       # Configurable thresholds
│       │   └── responsive_config.dart       # Global configuration
│       ├── value/                           # Logic layer
│       │   └── responsive_value.dart        # Generic value holder
│       ├── extensions/                      # Convenience extensions
│       │   ├── context_extensions.dart      # context.responsive()
│       │   └── numeric_extensions.dart      # .sp, .w, .h
│       └── widgets/                         # Pre-built widgets
│           ├── responsive_builder.dart      # Layout switching
│           ├── responsive_text.dart         # Auto-scaling text
│           ├── responsive_image.dart        # Adaptive images
│           ├── responsive_padding.dart      # Adaptive spacing
│           ├── responsive_grid.dart         # Responsive columns
│           └── responsive_visibility.dart   # Show/hide logic
├── test/
│   └── respix_test.dart                     # Comprehensive tests
├── example/
│   └── lib/main.dart                        # Working example app
├── README.md                                # Full documentation
├── QUICK_START.md                           # Quick reference
├── ARCHITECTURE.md                          # Technical details
└── CHANGELOG.md                             # Version history
```

## Core Features

### 1. Five Breakpoints
- Mobile: < 600px
- Tablet: 600-900px
- Laptop: 900-1200px
- Desktop: 1200-1600px
- Web: > 1600px

### 2. Smart Cascade Fallback
Only specify values that change. Unspecified breakpoints automatically fall back to smaller sizes.

### 3. Type-Safe Generics
Works with any type: `int`, `double`, `Widget`, `Color`, `EdgeInsets`, etc.

### 4. Context Extensions
Natural Flutter API using `context.responsive()`, `context.isMobile`, etc.

### 5. Pre-Built Widgets
Ready-to-use responsive components for common use cases.

### 6. Zero Dependencies
Pure Flutter implementation with no external packages.

## API Overview

### Configuration (One Time)
```dart
ResponsiveConfig(
  designSize: Size(375, 812),
  breakpointConfig: BreakpointConfig.defaultConfig,
  child: MyApp(),
)
```

### Responsive Values
```dart
context.responsive<T>(
  mobile: value1,
  tablet: value2,
  laptop: value3,
  desktop: value4,
  web: value5,
)
```

### Breakpoint Checks
```dart
context.breakpoint      // Enum
context.isMobile        // bool
context.isTablet        // bool
context.isLaptop        // bool
context.isDesktop       // bool
context.isWeb           // bool
```

### Widgets
- `ResponsiveBuilder` - Different layouts per breakpoint
- `ResponsiveText` - Auto-scaling text
- `ResponsiveImage` - Adaptive images
- `ResponsivePadding` - Adaptive padding
- `ResponsiveSpacing` - Adaptive spacing
- `ResponsiveGrid` - Responsive grid columns
- `ResponsiveVisibility` - Show/hide per breakpoint

## Usage Examples

### Simple Value
```dart
padding: EdgeInsets.all(
  context.responsive(mobile: 8, desktop: 16)
)
```

### Layout Switching
```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  desktop: (context) => DesktopLayout(),
)
```

### Visibility Control
```dart
ResponsiveVisibility.desktopAndUp(
  child: Sidebar(),
)
```

## Testing

All core functionality is tested:
- ✅ Breakpoint detection
- ✅ Cascade fallback logic
- ✅ Widget rendering
- ✅ Context extensions
- ✅ Custom configurations

Run tests: `flutter test`

## Documentation

- **README.md** - Complete guide with examples
- **QUICK_START.md** - Quick reference for common tasks
- **ARCHITECTURE.md** - Technical implementation details
- **example/** - Working demo application

## Design Principles

1. **Minimal Boilerplate** - One line to make anything responsive
2. **Type Safety** - Catch errors at compile time
3. **Smart Defaults** - Sensible fallback behavior
4. **Flutter-Native** - Feels like built-in Flutter
5. **Zero Magic** - Explicit and predictable

## Performance

- O(1) breakpoint detection
- Efficient InheritedWidget updates
- MediaQuery-based (standard Flutter approach)
- Tree-shakeable (unused code removed)

## Browser/Platform Support

Works on all Flutter platforms:
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## Version

Current version: **0.0.1**

## License

MIT License

## Getting Started

1. Add to `pubspec.yaml`:
```yaml
dependencies:
  respix: ^0.0.1
```

2. Wrap your app:
```dart
ResponsiveConfig(
  child: MyApp(),
)
```

3. Use anywhere:
```dart
context.responsive(mobile: 8, desktop: 16)
```

That's it! See README.md for complete documentation.
