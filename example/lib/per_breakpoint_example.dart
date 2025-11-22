import 'package:flutter/material.dart';
import 'package:respix/respix.dart';

/// Example showing per-breakpoint design sizes
/// This is useful when you have different design references for each device type
void main() {
  runApp(const PerBreakpointExample());
}

class PerBreakpointExample extends StatelessWidget {
  const PerBreakpointExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveConfig(
      // Option 1: Set different design sizes for each breakpoint
      mobileDesignSize: const Size(375, 812),    // iPhone 11 Pro design
      tabletDesignSize: const Size(768, 1024),   // iPad design
      laptopDesignSize: const Size(1366, 768),   // Laptop design
      desktopDesignSize: const Size(1920, 1080), // Desktop design
      webDesignSize: const Size(2560, 1440),     // Large screen design
      
      // Option 2: Custom breakpoint thresholds
      breakpointConfig: const BreakpointConfig(
        mobile: 480,   // < 480px = mobile
        tablet: 768,   // 480-768px = tablet
        laptop: 1024,  // 768-1024px = laptop
        desktop: 1440, // 1024-1440px = desktop
        // > 1440px = web
      ),
      
      child: MaterialApp(
        title: 'Per-Breakpoint Design Sizes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const DesignSizeDemo(),
      ),
    );
  }
}

class DesignSizeDemo extends StatelessWidget {
  const DesignSizeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Per-Breakpoint Design Sizes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: ResponsivePadding.all(
          mobile: 16,
          tablet: 24,
          laptop: 32,
          desktop: 48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current breakpoint info
              _InfoCard(
                title: 'Current Configuration',
                children: [
                  _InfoRow('Breakpoint', context.breakpoint.name.toUpperCase()),
                  _InfoRow('Screen Width', '${context.screenWidth.toStringAsFixed(0)}px'),
                  _InfoRow('Screen Height', '${context.screenHeight.toStringAsFixed(0)}px'),
                  _InfoRow('Design Width', '${context.designSize.width.toStringAsFixed(0)}px'),
                  _InfoRow('Design Height', '${context.designSize.height.toStringAsFixed(0)}px'),
                ],
              ),

              const SizedBox(height: 24),

              // Show design size for each breakpoint
              _InfoCard(
                title: 'Design Sizes Per Breakpoint',
                children: [
                  _InfoRow('Mobile', _formatSize(context.designSizeFor(Breakpoint.mobile))),
                  _InfoRow('Tablet', _formatSize(context.designSizeFor(Breakpoint.tablet))),
                  _InfoRow('Laptop', _formatSize(context.designSizeFor(Breakpoint.laptop))),
                  _InfoRow('Desktop', _formatSize(context.designSizeFor(Breakpoint.desktop))),
                  _InfoRow('Web', _formatSize(context.designSizeFor(Breakpoint.web))),
                ],
              ),

              const SizedBox(height: 24),

              // Scaled pixel demonstration
              _InfoCard(
                title: 'Scaled Pixels (.sp) Demo',
                children: [
                  const Text(
                    'These text sizes use .sp() which scales based on the current breakpoint\'s design size:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '16.sp = ${16.sp(context).toStringAsFixed(1)}px',
                    style: TextStyle(fontSize: 16.sp(context)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '20.sp = ${20.sp(context).toStringAsFixed(1)}px',
                    style: TextStyle(fontSize: 20.sp(context)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '24.sp = ${24.sp(context).toStringAsFixed(1)}px',
                    style: TextStyle(fontSize: 24.sp(context)),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Responsive layout example
              ResponsiveBuilder(
                mobile: (context) => _MobileCard(),
                tablet: (context) => _TabletCard(),
                laptop: (context) => _LaptopCard(),
                desktop: (context) => _DesktopCard(),
                web: (context) => _WebCard(),
              ),

              const SizedBox(height: 24),

              // Explanation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How It Works',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Each breakpoint can have its own design reference size\n'
                      '• The .sp() extension scales values based on the current breakpoint\'s design size\n'
                      '• If a breakpoint\'s design size is not specified, it cascades from smaller breakpoints\n'
                      '• This ensures accurate scaling for each device category',
                      style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatSize(Size size) {
    return '${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}';
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.phone_android, size: 48, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            'Mobile Layout',
            style: TextStyle(
              fontSize: 18.sp(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Design: 375×812',
            style: TextStyle(fontSize: 14.sp(context), color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _TabletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.tablet, size: 56, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tablet Layout',
                  style: TextStyle(
                    fontSize: 20.sp(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Design: 768×1024',
                  style: TextStyle(fontSize: 14.sp(context), color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LaptopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.teal.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Laptop Layout',
                style: TextStyle(
                  fontSize: 22.sp(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Design: 1366×768',
                style: TextStyle(fontSize: 14.sp(context), color: Colors.white70),
              ),
            ],
          ),
          const Icon(Icons.laptop, size: 64, color: Colors.white),
        ],
      ),
    );
  }
}

class _DesktopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.orange.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.computer, size: 72, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Desktop Layout',
                style: TextStyle(
                  fontSize: 24.sp(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Design: 1920×1080',
                style: TextStyle(fontSize: 16.sp(context), color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WebCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(64),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade400, Colors.red.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.desktop_windows, size: 80, color: Colors.white),
          const SizedBox(width: 32),
          Column(
            children: [
              Text(
                'Web Layout',
                style: TextStyle(
                  fontSize: 28.sp(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Design: 2560×1440',
                style: TextStyle(fontSize: 18.sp(context), color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
