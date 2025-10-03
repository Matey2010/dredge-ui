import 'package:flutter/material.dart';

class ToastProvider extends ChangeNotifier {
  Widget? _currentToast;
  bool _isVisible = false;

  Widget? get currentToast => _currentToast;
  bool get isVisible => _isVisible;

  void showToast(Widget toast) {
    // If there's already a toast showing, hide it first
    if (_isVisible) {
      closeToast();
      // Small delay to allow previous toast to hide before showing new one
      Future.delayed(const Duration(milliseconds: 150), () {
        _showToastInternal(toast);
      });
    } else {
      _showToastInternal(toast);
    }
  }

  void _showToastInternal(Widget toast) {
    _currentToast = toast;
    _isVisible = true;
    notifyListeners();
  }

  void closeToast() {
    _isVisible = false;
    notifyListeners();

    // Clear the toast after animation completes
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_isVisible) {
        _currentToast = null;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _currentToast = null;
    super.dispose();
  }
}
