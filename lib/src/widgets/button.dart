import 'package:flutter/material.dart';
import 'package:dredge_ui/widgets.dart';

class DredgeButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? splashColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? elevation;
  final Border? border;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool enabled;

  const DredgeButton({
    Key? key,
    this.onTap,
    this.text,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.icon,
    this.elevation,
    this.border,
    this.gradient,
    this.width,
    this.height = 38.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onTap != null;

    final effectiveBackgroundColor = isEnabled
        ? (backgroundColor ?? const Color(0xFF007AFF))
        : (disabledBackgroundColor ?? const Color(0xFFE5E5EA));

    final effectiveForegroundColor = isEnabled
        ? (foregroundColor ?? Colors.white)
        : (disabledForegroundColor ?? const Color(0xFF8E8E93));

    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(8);
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    Widget buttonContent;
    if (child != null) {
      buttonContent = child!;
    } else if (text != null) {
      final effectiveTextStyle =
          textStyle?.copyWith(color: effectiveForegroundColor) ??
              TextStyle(
                color: effectiveForegroundColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              );

      if (icon != null) {
        buttonContent = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            IconTheme(
              data: IconThemeData(color: effectiveForegroundColor, size: 16),
              child: icon!,
            ),
            const SizedBox(width: 6),
            Text(text!, style: effectiveTextStyle),
          ],
        );
      } else {
        buttonContent = Text(text!, style: effectiveTextStyle);
      }
    } else {
      buttonContent = const SizedBox.shrink();
    }

    buttonContent = DefaultTextStyle(
      style: TextStyle(
        color: foregroundColor,
      ),
      child: buttonContent,
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: gradient == null ? effectiveBackgroundColor : null,
        gradient: gradient,
        borderRadius: effectiveBorderRadius,
        border: border,
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: Offset(0, elevation! / 2),
                  blurRadius: elevation!,
                ),
              ]
            : null,
      ),
      child: Tappable(
        onTap: isEnabled ? onTap : null,
        borderRadius: effectiveBorderRadius,
        splashColor: splashColor,
        highlightColor: highlightColor,
        padding: effectivePadding,
        fillParent: false,
        child: Center(child: buttonContent),
      ),
    );
  }
}
