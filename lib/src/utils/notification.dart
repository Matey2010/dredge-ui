import 'package:flutter/material.dart';
import 'package:dredge_ui/src/models/notification_type.dart';

class NotificationUtils {
  static Color getDefaultColorForNotification(NotificationType type) {
    switch (type) {
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
    }
  }
}
