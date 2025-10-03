import 'package:dredge_ui/src/utils/notification.dart';
import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../models/notification_type.dart';

class NotificationWidget extends StatelessWidget {
  final DredgeNotification notification;
  final bool showIcon;
  final IconData? icon;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function()? onClose;
  final Color iconColor;
  final Color titleColor;
  final Color descriptionColor;

  const NotificationWidget({
    super.key,
    required this.notification,
    this.showIcon = true,
    this.icon,
    this.decoration,
    this.margin,
    this.padding,
    this.onClose,
    this.iconColor = Colors.black,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
  });

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Icons.error;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = NotificationUtils.getDefaultColorForNotification(
      notification.type,
    );
    final defaultDecoration = BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(4.0),
      decoration: decoration != null
          ? defaultDecoration.copyWith(
              color: decoration!.color ?? defaultDecoration.color,
              border: decoration!.border ?? defaultDecoration.border,
              borderRadius:
                  decoration!.borderRadius ?? defaultDecoration.borderRadius,
              boxShadow: decoration!.boxShadow ?? defaultDecoration.boxShadow,
              gradient: decoration!.gradient ?? defaultDecoration.gradient,
            )
          : defaultDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showIcon) ...[
            Icon(
              icon ?? _getIconForType(notification.type),
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (notification.title != null)
                  Text(
                    notification.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: titleColor,
                    ),
                  ),
                if (notification.description != null) ...[
                  if (notification.title != null) const SizedBox(height: 4),
                  Text(
                    notification.description!,
                    style: TextStyle(fontSize: 12, color: descriptionColor),
                  ),
                ],
              ],
            ),
          ),
          if (onClose != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClose,
              child: Icon(Icons.close, color: Colors.black, size: 16),
            ),
          ],
        ],
      ),
    );
  }
}
