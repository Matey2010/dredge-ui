import 'package:core/constants.dart';
import 'package:core/providers.dart';
import 'package:core/src/utils/string.dart';
import 'package:core/src/widget/touchable.dart';
import 'package:dredge_ui/src/models/modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalHeader extends StatelessWidget {
  final EdgeInsets padding;
  final String? label;
  final TextStyle? labelStyle;
  final bool? translateLabel;
  final Map<String, String> labelParams;
  final void Function() onClose;
  final ModalHeaderIconPosition iconPosition;
  final IconData? icon;

  const ModalHeader({
    required this.onClose,
    this.padding = EdgeInsets.zero,
    this.labelParams = const {},
    this.translateLabel,
    this.label,
    this.labelStyle,
    this.iconPosition = ModalHeaderIconPosition.right,
    this.icon,
    Key? key,
  }) : super(key: key);

  String getLabelText(TranslationProvider translationProvider) {
    if (label == null) {
      return "";
    }

    return translateLabel ?? true
        ? translationProvider.getTranslate(label!, params: labelParams)
        : label!;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final translationProvider = context.watch<TranslationProvider>();

    return Container(
      padding: padding,
      constraints: BoxConstraints(
        minHeight: padding.top + padding.bottom + ModalHeaderMinHeight,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: themeProvider.palette.border, width: 1),
        ),
        color: themeProvider.palette.material,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SizedBox(height: ModalHeaderMinHeight)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                transformText(
                  getLabelText(translationProvider),
                  TextTransform.uppercase,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: themeProvider.palette.textForMaterial,
                ).merge(labelStyle),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: iconPosition == ModalHeaderIconPosition.Left ? 0 : null,
            right: iconPosition == ModalHeaderIconPosition.Right ? 0 : null,
            width: 55,
            child: Touchable(
              onTap: onClose,
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  icon ?? Icons.close,
                  size: 25,
                  color: themeProvider.palette.icon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
