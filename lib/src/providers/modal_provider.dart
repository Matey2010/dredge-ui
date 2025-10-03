import 'package:dredge_ui/src/models/modal.dart';
import 'package:dredge_ui/src/utils/number.dart';
import 'package:flutter/material.dart';

class ModalProvider extends ChangeNotifier {
  ModalProvider();

  List<ModalStackItem> stack = [];

  Alignment alignment = Alignment.center;
  Widget? modal;

  bool get isModalVisible {
    return stack.isNotEmpty;
  }

  int openModal(
    Widget modal, {
    Alignment alignment = Alignment.center,
    bool shouldCloseOnBackdropClick = true,
    bool ignoreLayoutPadding = false,
  }) {
    final item = ModalStackItem(
      shouldCloseOnBackdropClick: shouldCloseOnBackdropClick,
      widget: modal,
      id: generateRandomInt(min: 100000, max: 1000000),
      alignment: alignment,
      ignoreLayoutPadding: ignoreLayoutPadding,
    );

    stack.add(item);
    notifyListeners();

    return item.id;
  }

  void popModal() {
    if (stack.isNotEmpty) {
      stack.removeLast();
      notifyListeners();
    }
  }

  void closeModal(int? modalId) {
    if (modalId != null) {
      stack.removeWhere((element) => element.id == modalId);
      notifyListeners();
    }
  }
}
