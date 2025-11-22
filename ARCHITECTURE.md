# Respix Architecture

## Design Philosophy

Respix follows a **3-layer architecture** for maximum simplicity and maintainability:

```
┌─────────────────────────────────────┐
│      Widget Layer (UI)              │
│  ResponsiveBuilder, ResponsiveText  │
│  ResponsivePadding, etc.            │
└──────────────┬──────────────────────┘
               │ uses
┌──────────────▼──────────────────────┐
│      Value Layer (Logic)            │
│  ResponsiveValue, context.responsive│
└──────────────┬──────────────────────┘
               │ uses
┌──────────────▼──────────────────────┐
│      Core Layer (Foundation)        │
│  Breakpoint, BreakpointConfig       │
│  ResponsiveConfig                   │
└─────────────────────────────────────┘
```

## Layer Breakdown

### 1. Core Layer (`lib/src/core/`)

**Purpose**: Foundation - breakpoint detection and configuration

**Files**:
- `breakpoint.dart` - Enum for 5 breakpoints
- `breakpoint_config.dart` - Configurable thresholds
- `responsive_config.dart` - InheritedWidget for global config

**Key Concept**: Uses `MediaQuery` to detect screen width and map to breakpoints.

### 2. Value Layer (`lib/src/value/` + `lib/src/extensions/`)

**Purpose**: Generic value resolution with cascade fallback

**Files**:
- `responsive_value.dart` - Generic value holder
- `context_extensions.dart` - `context.responsive<T>()` method
- `numeric_extensions.dart` - `.sp`, `.w`, `.h` extensions

**Key Concept**: Type-safe generic function that works with any type (int, double, Widget, Color, etc.)

**Cascade Logic**:
```dart
// If tablet not specified, use mobile
// If laptop not specified, use tablet (or mobile)
// If desktop not specified, use laptop (or tablet or mobile)
// If web not specified, use desktop (or laptop or tablet or mobile)
```

### 3. Widget Layer (`lib/src/widgets/`)

**Purpose**: Pre-built responsive widgets using the value layer

**Files**:
- `responsive_builder.dart` - Layout switching
- `responsive_text.dart` - Auto-scaling text
- `responsive_image.dart` - Adaptive images
- `responsive_padding.dart` - Adaptive spacing
- `responsive_grid.dart` - Responsive columns
- `responsive_visibility.dart` - Show/hide logic

**Key Concept**: Each widget internally uses `context.responsive()` to get the right value.

## Data Flow

```
User Code
    ↓
context.responsive(mobile: 8, desktop: 16)
    ↓
ResponsiveContext extension
    ↓
Get current breakpoint from MediaQuery
    ↓
Apply cascade fallback logic
    ↓
Return appropriate value
```

## Key Design Decisions

### 1. InheritedWidget for Configuration

**Why**: Allows global configuration without passing props through every widget.

```dart
ResponsiveConfig(
  breakpointConfig: customConfig,
  child: MyApp(),
)
```

### 2. Extension Methods on BuildContext

**Why**: Most natural API for Flutter developers. No extra objects to create.

```dart
context.responsive(...)  // Feels native
context.isMobile         // Clean and simple
```

### 3. Generic Type Parameter

**Why**: Works with any type without code generation.

```dart
context.responsive<int>(...)
context.responsive<Color>(...)
context.responsive<Widget>(...)
```

### 4. Cascade Fallback

**Why**: Reduces boilerplate. Only specify what changes.

```dart
// Instead of:
context.responsive(
  mobile: 8,
  tablet: 8,
  laptop: 8,
  desktop: 16,
  web: 16,
)

// Just write:
context.responsive(
  mobile: 8,
  desktop: 16,
)
```

### 5. No Code Generation

**Why**: Faster development, simpler setup, no build_runner needed.

## Performance Considerations

1. **MediaQuery Dependency**: Widgets rebuild when screen size changes (expected behavior)
2. **InheritedWidget**: Efficient updates only when config changes
3. **No Computation**: Breakpoint detection is O(1) comparison
4. **Tree-Shakeable**: Unused widgets are removed in production builds

## Extension Points

### Custom Breakpoints

```dart
ResponsiveConfig(
  breakpointConfig: BreakpointConfig(
    mobile: 480,
    tablet: 768,
    // ...
  ),
)
```

### Custom Design Size

```dart
ResponsiveConfig(
  designSize: Size(414, 896), // iPhone 11 Pro Max
)
```

### Custom Widgets

Build your own using the value layer:

```dart
class MyResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.responsive<MyType>(
      mobile: mobileValue,
      desktop: desktopValue,
    );
    return MyWidget(value: value);
  }
}
```

## Testing Strategy

1. **Unit Tests**: Test breakpoint detection logic
2. **Widget Tests**: Test responsive widgets at different sizes
3. **Integration Tests**: Test complete responsive layouts

See `test/respix_test.dart` for examples.

## Future Enhancements (Potential)

- Orientation support (portrait/landscape)
- Height-based breakpoints
- Custom breakpoint names
- Animation between breakpoint changes
- DevTools integration for debugging

## Comparison to Other Solutions

| Feature | Respix | responsive_builder | flutter_screenutil |
|---------|--------|-------------------|-------------------|
| Breakpoints | 5 (customizable) | 4 | N/A |
| Type-safe | ✅ | ❌ | ❌ |
| Zero deps | ✅ | ❌ | ❌ |
| Cascade fallback | ✅ | ❌ | N/A |
| Context extensions | ✅ | ❌ | ✅ |
| Pre-built widgets | ✅ | ✅ | ❌ |
| Code generation | ❌ | ❌ | ❌ |

## Summary

Respix achieves simplicity through:
- **Layered architecture** - Clear separation of concerns
- **Smart defaults** - Cascade fallback reduces code
- **Type safety** - Generics catch errors at compile time
- **Flutter-native API** - Feels like built-in Flutter
- **Zero magic** - Explicit and predictable behavior
