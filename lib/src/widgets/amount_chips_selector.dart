import 'package:flutter/material.dart';
import 'tappable.dart';

/// Universal widget for generating amount chips based on percentages from base amount
/// 
/// Creates chips with predefined or custom percentages of a base amount.
/// When a chip is tapped, calls callback with calculated amount.
/// 
/// Example usage:
/// ```dart
/// AmountChipsSelector(
///   baseAmount: 1000.0,
///   onAmountSelected: (amount) {
///     // Handle selected amount (e.g., update text field)
///     textController.text = amount.toInt().toString();
///   },
///   percentages: [10, 25, 50, 75, 90], // Optional, uses default
///   showMaxChip: true, // Optional, shows MAX (100%) chip
///   minAmount: 1.0, // Optional, minimum validation
///   maxAmount: 10000.0, // Optional, maximum validation  
/// )
/// ```
class AmountChipsSelector extends StatefulWidget {
  /// Base amount to calculate percentages from
  final double baseAmount;

  /// Callback when an amount is selected
  final ValueChanged<double> onAmountSelected;

  /// List of percentages to create chips for
  /// Default: [10, 25, 50, 75, 90]
  final List<int> percentages;

  /// Whether to show MAX chip (100% of base amount)
  /// Default: false
  final bool showMaxChip;

  /// Minimum amount validation (optional)
  final double? minAmount;

  /// Maximum amount validation (optional)
  final double? maxAmount;

  /// Custom chip border and text color
  /// Default: purple (#6B46C1)
  final Color? chipColor;

  /// Custom chip border color (separate from text color)
  /// If not provided, uses chipColor
  final Color? borderColor;

  /// Optional currency suffix (e.g., "USD", "EUR")
  final String? currency;

  /// Spacing between chips
  final double spacing;

  /// Run spacing between rows
  final double runSpacing;

  const AmountChipsSelector({
    Key? key,
    required this.baseAmount,
    required this.onAmountSelected,
    this.percentages = const [10, 25, 50, 75, 90],
    this.showMaxChip = false,
    this.minAmount,
    this.maxAmount,
    this.chipColor,
    this.borderColor,
    this.currency,
    this.spacing = 8,
    this.runSpacing = 8,
  }) : super(key: key);

  @override
  State<AmountChipsSelector> createState() => _AmountChipsSelectorState();
}

class _AmountChipsSelectorState extends State<AmountChipsSelector> {

  int? _selectedChipIndex;

  /// Default purple color for chips
  Color get _defaultChipColor => const Color(0xFF6B46C1);

  /// Calculate amount based on percentage
  double _calculateAmount(int percentage) {
    return widget.baseAmount * (percentage / 100.0);
  }

  /// Smart rounding for nice round numbers based on examples
  double _smartRound(double amount) {
    if (amount < 1) return amount;

    if (amount < 10) {
      // For amounts 1-10: round to 0.5 increments
      return (amount * 2).round() / 2; // 1, 1.5, 2, 2.5, 3, etc.
    } else if (amount < 100) {
      // For amounts 10-100: round to 5 or 10
      if (amount <= 50) {
        return (amount / 5).round() * 5.0; // 10, 15, 20, 25, etc.
      } else {
        return (amount / 10).round() * 10.0; // 50, 60, 70, 80, 90
      }
    } else if (amount < 1000) {
      // For amounts 100-1000: round to 50 (based on your examples)
      return (amount / 50).round() * 50.0; // 100, 150, 200, 250, 300, 350, 400, 450, etc.
    } else if (amount < 10000) {
      // For amounts 1000-10000: round to 50 for lower amounts, 100 for higher
      if (amount <= 2500) {
        return (amount / 50).round() * 50.0; // 1000, 1050, 1100, 1150, etc.
      } else {
        return (amount / 100).round() * 100.0; // 3000, 3100, 3200, 3300, etc.
      }
    } else {
      // For amounts > 10000: round to nearest 500
      return (amount / 500).round() * 500.0; // 10000, 10500, 11000, etc.
    }
  }

  /// Format amount with optional currency
  String _formatAmount(double amount, {String? currency}) {
    // Amount is already rounded when passed here, don't double-round
    final formattedNumber = amount == amount.toInt()
        ? amount.toInt().toString()
        : amount.toString();

    if (currency != null && currency.isNotEmpty) {
      return '$formattedNumber $currency';
    }
    return formattedNumber;
  }

  /// Check if amount passes validation
  bool _isAmountValid(double amount) {
    if (widget.minAmount != null && amount < widget.minAmount!) return false;
    if (widget.maxAmount != null && amount > widget.maxAmount!) return false;
    return true;
  }

  /// Handle chip tap
  void _onChipTapped(int index, double amount) {
    setState(() {
      _selectedChipIndex = index;
    });

    // Call callback with selected amount
    widget.onAmountSelected(amount);

    // Clear selection after visual feedback
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _selectedChipIndex = null;
        });
      }
    });
  }

  /// Build individual chip with adaptive sizing
  Widget _buildChip({
    required String label,
    required double amount,
    required int index,
    required bool isSelected,
  }) {
    final chipColor = widget.chipColor ?? _defaultChipColor;
    final borderColor = widget.borderColor ?? chipColor;
    final formattedAmount = _formatAmount(amount);
    final fontSize = _getFontSize(formattedAmount);

    return Tappable(
      onTap: () => _onChipTapped(index, amount),
      borderRadius: BorderRadius.circular(6),
      fillParent: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isSelected ? Color.fromRGBO(borderColor.red, borderColor.green, borderColor.blue, 0.8) : borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: chipColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get adaptive font size based on text length
  double _getFontSize(String text) {
    if (text.length > 8) {
      return 12.0;
    } else if (text.length > 6) {
      return 13.0;
    }
    return 14.0;
  }

  @override
  Widget build(BuildContext context) {
    // Don't show chips if base amount is 0 or negative
    if (widget.baseAmount <= 0) {
      return const SizedBox.shrink();
    }

    final chips = <Widget>[];
    int chipIndex = 0;

    // Add percentage chips showing amounts (only if they pass validation)
    for (int i = 0; i < widget.percentages.length; i++) {
      final percentage = widget.percentages[i];
      final originalAmount = _calculateAmount(percentage);
      final roundedAmount = _smartRound(originalAmount); // Use rounded amount for callback
      final label = _formatAmount(roundedAmount, currency: widget.currency); // Use rounded for display too!

      // Only add chip if amount is valid
      if (_isAmountValid(originalAmount)) {
        chips.add(_buildChip(
          label: label,
          amount: roundedAmount, // Pass rounded amount to callback
          index: chipIndex,
          isSelected: _selectedChipIndex == chipIndex,
        ));
        chipIndex++;
      }
    }

    // Add MAX chip if requested (only if it passes validation)
    if (widget.showMaxChip && _isAmountValid(widget.baseAmount)) {
      chips.add(_buildChip(
        label: 'MAX',
        amount: widget.baseAmount,
        index: chipIndex,
        isSelected: _selectedChipIndex == chipIndex,
      ));
    }

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: chips,
    );
  }
}