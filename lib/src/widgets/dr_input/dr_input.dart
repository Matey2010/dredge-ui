import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? value;
  final ValueChanged<String>? onChange;
  final String? label;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final InputDecoration? decoration;

  const DrInput({
    super.key,
    this.controller,
    this.value,
    this.onChange,
    this.label,
    this.enabled = true,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
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
  State<DrInput> createState() => _DrInputState();
}

class _DrInputState extends State<DrInput> with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _labelAnimation;

  bool get _isFocused => _focusNode.hasFocus;
  bool get _hasText => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _labelAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);

    if (_hasText) {
      _animationController.value = 1.0;
    }
  }

  void _onFocusChange() {
    if (_isFocused || _hasText) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onTextChange() {
    if (_hasText && _animationController.value == 0.0) {
      _animationController.forward();
    } else if (!_hasText && !_isFocused && _animationController.value == 1.0) {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(DrInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller =
          widget.controller ?? TextEditingController(text: widget.value ?? '');
      _controller.addListener(_onTextChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChange);
    _focusNode.dispose();
    _animationController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: widget.backgroundColor != null
                ? null
                : Border.all(
                    color:
                        widget.borderColor ??
                        (_isFocused
                            ? (widget.focusedBorderColor ??
                                  const Color(0xFF007AFF))
                            : Colors.grey.shade400),
                    width: _isFocused ? 2 : 1,
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChange,
                  enabled: widget.enabled,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  inputFormatters: widget.inputFormatters,
                  style: widget.textStyle,
                  cursorColor: widget.cursorColor,
                  decoration:
                      widget.decoration?.copyWith(
                        border: widget.decoration?.border ?? InputBorder.none,
                        contentPadding:
                            widget.decoration?.contentPadding ??
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                      ) ??
                      const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                ),
              ),
              if (!widget.enabled)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.lock, size: 20, color: Colors.grey),
                ),
            ],
          ),
        ),
        if (widget.label != null)
          AnimatedBuilder(
            animation: _labelAnimation,
            builder: (context, child) {
              return Positioned(
                left: 0,
                top: 16 - (_labelAnimation.value * 20),
                child: Transform.scale(
                  scale: 0.75 - (_labelAnimation.value * 0.25),
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        widget.label!,
                        style:
                            widget.textStyle?.copyWith(fontSize: 16) ??
                            const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
