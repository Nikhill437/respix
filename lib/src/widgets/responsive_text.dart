import 'package:flutter/widgets.dart';
import '../extensions/context_extensions.dart';

/// Text widget that auto-scales based on screen size
class ResponsiveText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final double? mobileFontSize;
  final double? tabletFontSize;
  final double? laptopFontSize;
  final double? desktopFontSize;
  final double? webFontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;

  const ResponsiveText(
    this.data, {
    super.key,
    this.style,
    this.mobileFontSize,
    this.tabletFontSize,
    this.laptopFontSize,
    this.desktopFontSize,
    this.webFontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = context.responsive<double>(
      mobile: mobileFontSize ?? style?.fontSize ?? 14,
      tablet: tabletFontSize,
      laptop: laptopFontSize,
      desktop: desktopFontSize,
      web: webFontSize,
    );

    return Text(
      data,
      style: style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
