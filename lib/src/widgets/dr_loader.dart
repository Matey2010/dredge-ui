import 'package:flutter/material.dart';

class DrLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final double? strokeWidth;
  final double? indicatorSize;
  final Color? color;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Alignment alignment;
  final String? semanticsLabel;
  final String? semanticsValue;
  final Widget? child;
  final BorderRadius? borderRadius;
  final double? value;
  final Animation<Color?>? valueColor;
  final StrokeCap? strokeCap;

  const DrLoader({
    super.key,
    this.width,
    this.height,
    this.strokeWidth,
    this.indicatorSize,
    this.color,
    this.backgroundColor,
    this.decoration,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.semanticsValue,
    this.child,
    this.borderRadius,
    this.value,
    this.valueColor,
    this.strokeCap,
  });

  @override
  Widget build(BuildContext context) {
    Widget indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth ?? 4.0,
      valueColor:
          valueColor ??
          (color != null
              ? AlwaysStoppedAnimation<Color>(color!)
              : const AlwaysStoppedAnimation<Color>(Color(0xFF007AFF))),
      value: value,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeCap: strokeCap,
    );

    if (indicatorSize != null) {
      indicator = SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: indicator,
      );
    }

    Widget content = Align(
      alignment: alignment,
      child: child != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [indicator, const SizedBox(height: 12), child!],
            )
          : indicator,
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration:
          decoration ??
          (backgroundColor != null || borderRadius != null
              ? BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                )
              : null),
      child: content,
    );
  }
}
