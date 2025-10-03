import 'package:flutter/material.dart';

class Tappable extends StatelessWidget {
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Color? splashColor;
  final Color? highlightColor;
  final double? splashRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool fillParent;
  final EdgeInsetsGeometry? padding;

  const Tappable({
    Key? key,
    this.onTap,
    this.borderRadius,
    this.child,
    this.splashColor,
    this.highlightColor,
    this.splashRadius,
    this.splashFactory,
    this.fillParent = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = child ?? Container();

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (fillParent) {
      content = SizedBox.expand(child: content);
    }

    // If onTap is null, return just the content without interactive effects
    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: splashColor,
          highlightColor: highlightColor,
          radius: splashRadius,
          splashFactory: splashFactory,
          child: content,
        ),
      ),
    );
  }
}
