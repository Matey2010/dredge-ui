import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input.dart';

class AmountInput extends StatefulWidget {
  final TextEditingController? controller;
  final double? value;
  final ValueChanged<double>? onChange;
  final String? label;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final int? decimalPlaces;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final InputDecoration? decoration;

  const AmountInput({
    super.key,
    this.controller,
    this.value,
    this.onChange,
    this.label,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.decimalPlaces,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.textStyle,
    this.decoration,
  }) : assert(
         (controller != null) != (value != null && onChange != null),
         'Must provide either controller OR value/onChange, not both',
       );

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  late TextEditingController inputController;

  bool get isControllerMode => widget.controller != null;

  double get amount {
    final text = inputController.text;
    if (text.isEmpty) return 0.0;
    return double.tryParse(text) ?? 0.0;
  }

  String _formatDoubleForDisplay(double value) {
    if (value == 0.0) return '';

    // If the number is a whole number, don't show decimal places
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    // Otherwise, show the decimal but remove trailing zeros
    return value.toString().replaceAll(RegExp(r'\.?0+$'), '');
  }

  @override
  void initState() {
    super.initState();

    if (isControllerMode) {
      inputController = widget.controller!;
    } else {
      final initialValue = widget.value ?? 0.0;
      final initialText = _formatDoubleForDisplay(initialValue);
      inputController = TextEditingController(text: initialText);
    }

    if (!isControllerMode) {
      inputController.addListener(() {
        widget.onChange?.call(amount);
      });
    }
  }

  @override
  void didUpdateWidget(AmountInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!isControllerMode && widget.value != oldWidget.value) {
      final newValue = widget.value ?? 0.0;
      final newText = _formatDoubleForDisplay(newValue);
      inputController.text = newText;
    }
  }

  @override
  void dispose() {
    if (!isControllerMode) {
      inputController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: inputController,
      label: widget.label,
      enabled: widget.enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        _NumericTextInputFormatter(decimalPlaces: widget.decimalPlaces),
      ],
      backgroundColor: widget.backgroundColor,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      cursorColor: widget.cursorColor,
      textStyle: widget.textStyle,
      decoration: widget.decoration,
    );
  }
}

class _NumericTextInputFormatter extends TextInputFormatter {
  final int? decimalPlaces;

  _NumericTextInputFormatter({this.decimalPlaces});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Allow only digits, one decimal point, and handle negative numbers
    final regex = RegExp(r'^-?\d*\.?\d*$');
    if (!regex.hasMatch(newValue.text)) {
      return oldValue;
    }

    // Check if there's more than one decimal point
    final decimalCount = newValue.text.split('.').length - 1;
    if (decimalCount > 1) {
      return oldValue;
    }

    // Limit decimal places if specified
    if (decimalPlaces != null && newValue.text.contains('.')) {
      final parts = newValue.text.split('.');
      if (parts.length == 2 && parts[1].length > decimalPlaces!) {
        return oldValue;
      }
    }

    return newValue;
  }
}
