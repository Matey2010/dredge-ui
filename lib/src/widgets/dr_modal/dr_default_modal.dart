import 'package:dredge_ui/src/providers/modal_provider.dart';
import 'package:dredge_ui/src/widgets/dr_modal/dr_modal_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrDefaultModal extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxDecoration? headerDecoration;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;
  final BoxDecoration? decoration;
  final bool showHeader;
  final String? title;
  final TextStyle? titleStyle;
  final void Function()? onClose;
  final void Function()? onGoBack;

  const DrDefaultModal({
    this.padding,
    required this.child,
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    this.headerDecoration,
    this.headerPadding,
    this.showHeader = false,
    this.contentPadding,
    this.title,
    this.titleStyle,
    this.onClose,
    this.onGoBack,
    super.key,
  }) : assert(
         showHeader == false || title != null,
         'title is required when showHeader is true',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHeader)
            DrModalHeader(
              padding: headerPadding,
              title: title,
              titleStyle: titleStyle,
              onClose: onClose ?? context.read<ModalProvider>().popModal,
              onGoBack: onGoBack,
              decoration: headerDecoration,
            ),
          Flexible(
            child: Container(padding: contentPadding, child: child),
          ),
        ],
      ),
    );
  }
}
