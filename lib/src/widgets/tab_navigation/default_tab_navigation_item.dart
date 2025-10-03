import 'package:dredge_ui/src/models/select_option.dart';
import "package:flutter/material.dart";
import 'package:dredge_ui/src/widgets/tappable.dart';

class DefaultTabNavigationItem extends StatelessWidget {
  final void Function(dynamic) onSelect;
  final SelectOption tab;
  final int tabIndex;
  final bool isActive;
  final Widget? child;
  final String? translationSection;
  final Color? backgroundColor;
  final Color? activeHighlightColor;
  final Color? textColor;
  final Color? activeTextColor;
  final double height;

  const DefaultTabNavigationItem({
    required this.onSelect,
    required this.tabIndex,
    required this.isActive,
    required this.tab,
    this.child,
    this.height = 48.0,
    this.translationSection,
    this.backgroundColor = Colors.white,
    this.activeHighlightColor = Colors.blueAccent,
    this.activeTextColor = Colors.blueAccent,
    this.textColor = Colors.blueGrey,
    super.key,
  });

  tapHandler() {
    onSelect(tab.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: isActive ? activeHighlightColor! : Colors.transparent,
          ),
        ),
      ),
      child: Tappable(
        fillParent: false,
        onTap: tapHandler,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: height,
                alignment: Alignment.center,
                child:
                    child ??
                    Text(
                      tab.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: isActive
                            ? FontWeight.w500
                            : FontWeight.w300,
                        fontSize: 14,
                        color: isActive ? activeTextColor! : textColor!,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
