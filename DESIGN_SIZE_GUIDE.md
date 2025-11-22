# Design Size Configuration Guide

## Two Approaches to Design Sizes

Respix offers two flexible approaches for configuring design sizes:

### Approach 1: Single Design Size (Simple)
**Best for:** Apps with one primary design reference

```dart
ResponsiveConfig(
  designSize: const Size(375, 812), // Used for all breakpoints
  child: MyApp(),
)
```

**How it works:**
- One design size applies to all breakpoints
- `.sp()` scaling is consistent across all devices
- Simpler configuration

**Use when:**
- You have one Figma/Adobe XD design file
- Your design scales uniformly across devices
- You want simplicity

---

### Approach 2: Per-Breakpoint Design Sizes (Advanced)
**Best for:** Apps with different designs for each device type

```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),    // iPhone design
  tabletDesignSize: const Size(768, 1024),   // iPad design
  laptopDesignSize: const Size(1366, 768),   // Laptop design
  desktopDesignSize: const Size(1920, 1080), // Desktop design
  webDesignSize: const Size(2560, 1440),     // Large screen design
  child: MyApp(),
)
```

**How it works:**
- Each breakpoint has its own design reference
- `.sp()` scaling adapts to the current breakpoint's design size
- More accurate scaling per device category
- Cascade fallback: unspecified sizes inherit from smaller breakpoints

**Use when:**
- You have separate design files for mobile, tablet, and desktop
- Each device type has unique layouts and proportions
- You need precise control over scaling per device

---

## Comparison

| Feature | Single Design Size | Per-Breakpoint Design Sizes |
|---------|-------------------|----------------------------|
| Configuration | Simple | More detailed |
| Design Files | 1 design file | Multiple design files |
| Scaling Accuracy | Good | Excellent |
| Use Case | Uniform scaling | Device-specific designs |
| Complexity | Low | Medium |

---

## Examples

### Example 1: Mobile-First App (Single Design Size)

```dart
void main() {
  runApp(
    ResponsiveConfig(
      designSize: const Size(375, 812), // iPhone 11 Pro
      child: MyApp(),
    ),
  );
}

// Usage
Text(
  'Hello',
  style: TextStyle(fontSize: 16.sp(context)), // Scales from 375px base
)
```

**Result:**
- On 375px screen: 16px
- On 750px screen: 32px (2x scale)
- On 1500px screen: 64px (4x scale)

---

### Example 2: Multi-Device App (Per-Breakpoint)

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

// Usage
Text(
  'Hello',
  style: TextStyle(fontSize: 16.sp(context)), // Scales based on current breakpoint
)
```

**Result:**
- Mobile (375px): 16px (scales from 375px base)
- Tablet (768px): 16px (scales from 768px base)
- Desktop (1920px): 16px (scales from 1920px base)

Each breakpoint maintains its design proportions!

---

## Cascade Fallback Logic

When using per-breakpoint design sizes, unspecified sizes cascade:

```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),
  desktopDesignSize: const Size(1920, 1080),
  // tablet and laptop not specified
  child: MyApp(),
)
```

**Effective design sizes:**
- Mobile: 375×812 (specified)
- Tablet: 375×812 (falls back to mobile)
- Laptop: 375×812 (falls back to mobile)
- Desktop: 1920×1080 (specified)
- Web: 1920×1080 (falls back to desktop)

---

## Common Design Sizes

### Mobile
- iPhone SE: 375×667
- iPhone 11 Pro: 375×812
- iPhone 11 Pro Max: 414×896
- Pixel 5: 393×851
- Samsung Galaxy S21: 360×800

### Tablet
- iPad: 768×1024
- iPad Pro 11": 834×1194
- iPad Pro 12.9": 1024×1366
- Android Tablet: 800×1280

### Laptop
- MacBook Air: 1366×768
- MacBook Pro 13": 1440×900
- Standard Laptop: 1280×720

### Desktop
- Full HD: 1920×1080
- 2K: 2560×1440
- 4K: 3840×2160

---

## Best Practices

### 1. Match Your Design Tools
Use the exact dimensions from your Figma/Adobe XD files:

```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812), // From Figma mobile frame
  desktopDesignSize: const Size(1440, 900), // From Figma desktop frame
  child: MyApp(),
)
```

### 2. Use Cascade Fallback
Only specify what's different:

```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),
  desktopDesignSize: const Size(1920, 1080),
  // tablet/laptop will use mobile size
  child: MyApp(),
)
```

### 3. Test on Real Devices
Always test `.sp()` scaling on actual devices to ensure accuracy.

### 4. Combine with Custom Breakpoints
You can customize both breakpoints AND design sizes:

```dart
ResponsiveConfig(
  breakpointConfig: const BreakpointConfig(
    mobile: 480,
    tablet: 768,
    laptop: 1024,
    desktop: 1440,
  ),
  mobileDesignSize: const Size(360, 640),
  tabletDesignSize: const Size(768, 1024),
  desktopDesignSize: const Size(1920, 1080),
  child: MyApp(),
)
```

---

## Migration Guide

### From Single to Per-Breakpoint

**Before:**
```dart
ResponsiveConfig(
  designSize: const Size(375, 812),
  child: MyApp(),
)
```

**After:**
```dart
ResponsiveConfig(
  mobileDesignSize: const Size(375, 812),
  tabletDesignSize: const Size(768, 1024),
  desktopDesignSize: const Size(1920, 1080),
  child: MyApp(),
)
```

**Note:** Existing code using `.sp()` will automatically adapt to the new design sizes!

---

## FAQ

**Q: Can I mix both approaches?**  
A: Yes! Use `designSize` as a fallback and override specific breakpoints:

```dart
ResponsiveConfig(
  designSize: const Size(375, 812),      // Fallback
  desktopDesignSize: const Size(1920, 1080), // Override desktop only
  child: MyApp(),
)
```

**Q: Which approach should I use?**  
A: Start with single design size. Upgrade to per-breakpoint if you have multiple design files or need precise control.

**Q: Does this affect responsive values?**  
A: No. `context.responsive()` is independent of design sizes. Design sizes only affect `.sp()` scaling.

**Q: Can I change design sizes at runtime?**  
A: Yes, but not recommended. Wrap ResponsiveConfig in a StatefulWidget and rebuild when needed.

---

## Summary

- **Single Design Size**: Simple, one design file, uniform scaling
- **Per-Breakpoint Design Sizes**: Advanced, multiple design files, accurate per-device scaling
- **Cascade Fallback**: Unspecified sizes inherit from smaller breakpoints
- **Choose based on your design workflow**: Match your Figma/Adobe XD setup

Both approaches work seamlessly with all Respix features!
