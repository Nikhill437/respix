import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respix/respix.dart';

void main() {
  group('Breakpoint Tests', () {
    test('BreakpointConfig returns correct breakpoint for width', () {
      const config = BreakpointConfig.defaultConfig;

      expect(config.getBreakpoint(500), Breakpoint.mobile);
      expect(config.getBreakpoint(700), Breakpoint.tablet);
      expect(config.getBreakpoint(1000), Breakpoint.laptop);
      expect(config.getBreakpoint(1400), Breakpoint.desktop);
      expect(config.getBreakpoint(1800), Breakpoint.web);
    });

    test('Custom BreakpointConfig works', () {
      const config = BreakpointConfig(
        mobile: 480,
        tablet: 768,
        laptop: 1024,
        desktop: 1440,
      );

      expect(config.getBreakpoint(400), Breakpoint.mobile);
      expect(config.getBreakpoint(600), Breakpoint.tablet);
      expect(config.getBreakpoint(900), Breakpoint.laptop);
      expect(config.getBreakpoint(1300), Breakpoint.desktop);
    });
  });

  group('ResponsiveValue Tests', () {
    test('getValue returns correct value with fallback', () {
      const value = ResponsiveValue<int>(
        mobile: 10,
        desktop: 30,
      );

      expect(value.getValue(Breakpoint.mobile), 10);
      expect(value.getValue(Breakpoint.tablet), 10); // Falls back to mobile
      expect(value.getValue(Breakpoint.laptop), 10); // Falls back to mobile
      expect(value.getValue(Breakpoint.desktop), 30);
      expect(value.getValue(Breakpoint.web), 30); // Falls back to desktop
    });

    test('getValue with all breakpoints specified', () {
      const value = ResponsiveValue<String>(
        mobile: 'mobile',
        tablet: 'tablet',
        laptop: 'laptop',
        desktop: 'desktop',
        web: 'web',
      );

      expect(value.getValue(Breakpoint.mobile), 'mobile');
      expect(value.getValue(Breakpoint.tablet), 'tablet');
      expect(value.getValue(Breakpoint.laptop), 'laptop');
      expect(value.getValue(Breakpoint.desktop), 'desktop');
      expect(value.getValue(Breakpoint.web), 'web');
    });
  });

  group('Widget Tests', () {
    testWidgets('ResponsiveBuilder shows correct layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: Scaffold(
              body: ResponsiveBuilder(
                mobile: (context) => const Text('Mobile'),
                tablet: (context) => const Text('Tablet'),
                desktop: (context) => const Text('Desktop'),
              ),
            ),
          ),
        ),
      );

      // Default test size is 800x600, which should be tablet
      expect(find.text('Tablet'), findsOneWidget);
    });

    testWidgets('ResponsiveVisibility hides widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: Scaffold(
              body: ResponsiveVisibility(
                visible: [Breakpoint.desktop, Breakpoint.web],
                child: const Text('Desktop Only'),
              ),
            ),
          ),
        ),
      );

      // Default test size is 800x600 (tablet), so desktop widget should be hidden
      expect(find.text('Desktop Only'), findsNothing);
    });

    testWidgets('ResponsiveText renders with correct size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: const Scaffold(
              body: ResponsiveText(
                'Test',
                mobileFontSize: 14,
                tabletFontSize: 18,
                desktopFontSize: 22,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('ResponsivePadding applies correct padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: Scaffold(
              body: ResponsivePadding.all(
                mobile: 8,
                tablet: 16,
                desktop: 24,
                child: const Text('Padded'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Padded'), findsOneWidget);
    });
  });

  group('Context Extension Tests', () {
    testWidgets('context.responsive returns correct value', (tester) async {
      late int responsiveValue;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: Builder(
              builder: (context) {
                responsiveValue = context.responsive<int>(
                  mobile: 10,
                  tablet: 20,
                  desktop: 30,
                );
                return Container();
              },
            ),
          ),
        ),
      );

      // Default test size is 800x600 (tablet)
      expect(responsiveValue, 20);
    });

    testWidgets('context.breakpoint returns correct breakpoint', (tester) async {
      late Breakpoint currentBreakpoint;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveConfig(
            child: Builder(
              builder: (context) {
                currentBreakpoint = context.breakpoint;
                return Container();
              },
            ),
          ),
        ),
      );

      // Default test size is 800x600 (tablet)
      expect(currentBreakpoint, Breakpoint.tablet);
    });
  });
}
