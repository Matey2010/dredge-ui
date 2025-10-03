import 'package:dredge_ui/src/providers/modal_provider.dart';
import 'package:dredge_ui/src/widgets/modal/modal_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalLayout extends StatelessWidget {
  final EdgeInsets? padding;

  const ModalLayout({this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModalProvider>();

    if (!provider.isModalVisible) {
      return SizedBox.shrink();
    }

    return Container(
      child: Stack(
        children: provider.stack.map((item) {
          return ModalContainer(
            padding: item.ignoreLayoutPadding ? EdgeInsets.zero : padding,
            key: ValueKey(item.id),
            onClose: item.shouldCloseOnBackdropClick
                ? provider.closeModal
                : (id) {},
            item: item,
          );
        }).toList(),
      ),
    );
  }
}
