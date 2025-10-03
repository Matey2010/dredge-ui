import 'package:dredge_ui/src/models/notification_type.dart';
import 'package:flutter/widgets.dart';

class InputHint extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final NotificationType type;

  const InputHint({
    super.key,
    required this.text,
    this.textStyle,
    this.type = NotificationType.info,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}
