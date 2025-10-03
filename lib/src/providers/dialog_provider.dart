import 'package:flutter/material.dart';

class DialogProvider extends ChangeNotifier {
  bool isDialogVisible = false;
  Widget? dialog;

  openDialog(Widget dialog) {
    this.dialog = dialog;
    isDialogVisible = true;
    notifyListeners();
  }

  closeDialog() {
    dialog = null;
    isDialogVisible = false;
    notifyListeners();
  }
}
