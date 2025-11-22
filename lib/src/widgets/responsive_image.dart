import 'package:flutter/widgets.dart';
import '../extensions/context_extensions.dart';

/// Image widget that adapts size based on breakpoint
class ResponsiveImage extends StatelessWidget {
  final ImageProvider image;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? laptopWidth;
  final double? desktopWidth;
  final double? webWidth;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? laptopHeight;
  final double? desktopHeight;
  final double? webHeight;
  final BoxFit? fit;
  final AlignmentGeometry alignment;

  const ResponsiveImage({
    super.key,
    required this.image,
    this.mobileWidth,
    this.tabletWidth,
    this.laptopWidth,
    this.desktopWidth,
    this.webWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.laptopHeight,
    this.desktopHeight,
    this.webHeight,
    this.fit,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.responsive<double?>(
      mobile: mobileWidth,
      tablet: tabletWidth,
      laptop: laptopWidth,
      desktop: desktopWidth,
      web: webWidth,
    );

    final height = context.responsive<double?>(
      mobile: mobileHeight,
      tablet: tabletHeight,
      laptop: laptopHeight,
      desktop: desktopHeight,
      web: webHeight,
    );

    return Image(
      image: image,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}
