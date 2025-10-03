import 'package:dredge_ui/src/providers/modal_provider.dart';
import 'package:dredge_ui/src/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultModal extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final bool showHeader;
  final Widget? title;
  final void Function()? onClose;

  const DefaultModal({
    required this.child,
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    this.padding = const EdgeInsets.all(8),
    this.showHeader = false,
    this.title,
    this.onClose,
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
          if (showHeader) ...[
            Row(
              children: [
                Expanded(child: title ?? SizedBox.shrink()),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Tappable(
                    onTap: onClose ?? context.read<ModalProvider>().popModal,
                    child: Icon(Icons.close, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }
}
