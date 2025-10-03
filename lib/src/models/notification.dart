import 'notification_type.dart';

class DredgeNotification {
  final NotificationType type;
  final String? title;
  final String? description;
  final Map<String, dynamic>? params;

  const DredgeNotification({
    this.type = NotificationType.info,
    this.title,
    this.description,
    this.params,
  });
}
