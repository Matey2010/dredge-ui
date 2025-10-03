import 'package:dredge_ui/src/widgets/tappable.dart';
import 'package:flutter/material.dart';

class DrModalHeader extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onGoBack;
  final String? title;
  final TextStyle? titleStyle;
  final double? height;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const DrModalHeader({
    super.key,
    this.onClose,
    this.onGoBack,
    this.title,
    this.titleStyle,
    this.height,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration:
          BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ).copyWith(
            color: decoration?.color,
            image: decoration?.image,
            gradient: decoration?.gradient,
            boxShadow: decoration?.boxShadow,
            borderRadius: decoration?.borderRadius,
            shape: decoration?.shape,
          ),
      child: Row(
        children: [
          if (onGoBack != null)
            Tappable(
              onTap: onGoBack,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.arrow_back, color: Colors.blueGrey),
              ),
            )
          else
            const SizedBox(width: 40),
          Expanded(
            child: title != null
                ? Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ).merge(titleStyle),
                  )
                : const SizedBox.shrink(),
          ),
          if (onClose != null)
            Tappable(
              onTap: onClose,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.close, color: Colors.blueGrey),
              ),
            )
          else
            const SizedBox(width: 40),
        ],
      ),
    );
  }
}
