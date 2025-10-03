import 'package:flutter/cupertino.dart';

class ModalStackItem {
  final int id;
  final Widget widget;
  final Alignment alignment;
  final bool shouldCloseOnBackdropClick;
  final bool ignoreLayoutPadding;

  ModalStackItem({
    required this.id,
    required this.widget,
    required this.alignment,
    required this.shouldCloseOnBackdropClick,
    required this.ignoreLayoutPadding,
  });
}

enum ModalHeaderIconPosition { right, left }
