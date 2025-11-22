import 'package:flutter/widgets.dart';
import '../extensions/context_extensions.dart';

/// Grid widget that changes columns per breakpoint
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? laptopColumns;
  final int? desktopColumns;
  final int? webColumns;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns,
    this.tabletColumns,
    this.laptopColumns,
    this.desktopColumns,
    this.webColumns,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final columns = context.responsive<int>(
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns,
      laptop: laptopColumns,
      desktop: desktopColumns,
      web: webColumns,
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
