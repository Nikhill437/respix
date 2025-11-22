import 'package:flutter/material.dart';
import 'package:respix/respix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveConfig(
      designSize: const Size(375, 812),
      breakpointConfig: BreakpointConfig.defaultConfig,
      child: MaterialApp(
        title: 'Respix Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ResponsiveDemo(),
      ),
    );
  }
}

class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respix Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: ResponsivePadding.all(
          mobile: 16,
          tablet: 24,
          desktop: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breakpoint indicator
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Breakpoint: ${context.breakpoint.name.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Screen Width: ${context.screenWidth.toStringAsFixed(0)}'),
                    Text('Is Mobile: ${context.isMobile}'),
                    Text('Is Tablet: ${context.isTablet}'),
                    Text('Is Desktop: ${context.isDesktop}'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Responsive Text Example
              ResponsiveText(
                'Responsive Text',
                mobileFontSize: 20,
                tabletFontSize: 24,
                desktopFontSize: 28,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // Simple value selection
              Text(
                'Padding: ${context.responsive(mobile: 8, tablet: 16, desktop: 24)}',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 24),

              // Responsive Builder Example
              ResponsiveBuilder(
                mobile: (context) => _MobileLayout(),
                tablet: (context) => _TabletLayout(),
                desktop: (context) => _DesktopLayout(),
              ),

              const SizedBox(height: 24),

              // Responsive Visibility Example
              ResponsiveVisibility(
                visible: [Breakpoint.tablet, Breakpoint.desktop, Breakpoint.web],
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green.shade100,
                  child: const Text('Visible only on tablet and larger'),
                ),
              ),

              ResponsiveVisibility.mobile(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.orange.shade100,
                  child: const Text('Visible only on mobile'),
                ),
              ),

              const SizedBox(height: 24),

              // Responsive Grid Example
              SizedBox(
                height: 300,
                child: ResponsiveGrid(
                  mobileColumns: 2,
                  tabletColumns: 3,
                  desktopColumns: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: List.generate(
                    8,
                    (index) => Container(
                      color: Colors.primaries[index % Colors.primaries.length],
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: const Column(
        children: [
          Icon(Icons.phone_android, size: 48),
          SizedBox(height: 8),
          Text('Mobile Layout', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.purple.shade50,
      child: const Row(
        children: [
          Icon(Icons.tablet, size: 48),
          SizedBox(width: 16),
          Text('Tablet Layout', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.green.shade50,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.computer, size: 64),
          Text('Desktop Layout', style: TextStyle(fontSize: 24)),
          Icon(Icons.computer, size: 64),
        ],
      ),
    );
  }
}
