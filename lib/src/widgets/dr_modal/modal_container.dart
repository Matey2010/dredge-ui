import 'package:dredge_ui/src/models/modal.dart';
import 'package:flutter/material.dart';

class ModalContainer extends StatefulWidget {
  final ModalStackItem item;
  final EdgeInsets? padding;
  final Function(int) onClose;

  const ModalContainer({
    required this.onClose,
    required this.item,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  State<ModalContainer> createState() => _ModalContainerState();
}

class _ModalContainerState extends State<ModalContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack, // Choose your desired curve
      reverseCurve: Curves.easeInBack,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.item.alignment,
      children: [
        GestureDetector(
          onTap: () {
            widget.onClose(widget.item.id);
          },
          child: Container(color: Colors.black38),
        ),
        FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.item.widget,
          ),
        ),
      ],
    );
  }
}
