import 'package:flutter/material.dart';
import 'package:dredge_ui/providers.dart';
import 'package:dredge_ui/widgets.dart';
import 'package:provider/provider.dart';

class DialogLayout extends StatelessWidget {
  final EdgeInsets? padding;

  const DialogLayout({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();

    if (!provider.isDialogVisible) {
      return SizedBox.shrink();
    }

    return Container(
      padding: padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: Tappable(
                onTap: () {
                  provider.closeDialog();
                },
              ),
            ),
          ),
          provider.dialog!,
        ],
      ),
    );
  }
}
